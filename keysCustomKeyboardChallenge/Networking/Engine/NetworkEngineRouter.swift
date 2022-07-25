//
//  NetworkEngineRouter.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 24/07/22.
//

import Foundation
import Combine

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndpointTargetType
    func request<T: Codable>(target: EndPoint) -> AnyPublisher<T, Error>
    func cancel()
}

class NetworkEngineRouter<EndPoint: EndpointTargetType>: NetworkRouter {
    private var task: URLSessionTask?

    func request<T: Codable>(target: EndPoint) -> AnyPublisher<T, Error> {

        do {
            
            let request = try self.buildRequest(from: target)
            
            return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                HTTPLogger.log(request: request, response: httpResponse, data: element.data)

                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            
        } catch {
            return AnyPublisher(Fail<T, Error>(error: URLError(.badURL)))
        }
    }

    func cancel() {
        self.task?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {

        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)

        request.httpMethod = route.httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
