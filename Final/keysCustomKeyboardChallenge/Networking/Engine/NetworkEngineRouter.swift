//
//  NetworkEngineRouter.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 24/07/22.
//

import Foundation
import Combine

protocol NetworkRouter {
    associatedtype EndPoint: EndpointTargetType
    func request<T: Codable>(target: EndPoint) -> AnyPublisher<T, HTTPError>
}

class NetworkEngineRouter<EndPoint: EndpointTargetType>: NetworkRouter {
    
    func request<T: Codable>(target: EndPoint) -> AnyPublisher<T, HTTPError> {
        
        let urlRequest = self.buildRequest(from: target)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                HTTPLogger.log(request: urlRequest, response: httpResponse, data: element.data)
                
                return element.data
            }.decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> HTTPError in
                return HTTPError.randomError
            }.eraseToAnyPublisher()
    }
    
    private func buildRequest(from route: EndPoint) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = route.httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
