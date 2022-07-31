//
//  keysCustomKeyboardChallengeTests.swift
//  keysCustomKeyboardChallengeTests
//
//  Created by Raphael Oliveira on 27/07/22.
//

import XCTest
//import SwiftUI
import Combine
import ViewInspector

@testable import keysCustomKeyboardChallenge

//extension Inspection: InspectionEmissary { }
//extension LoadingView: Inspectable{ }
//extension LoadingView: Inspectable { }
//extension KeyboardContentView: Inspectable { }
//extension ErrorView: Inspectable { }
//extension BaseView: Inspectable {}

class keysCustomKeyboardChallengeTests: XCTestCase {
    
    /**
     `BR (Business Requirement)` represents our challenge requrements, so we will use `BDD` approach
     to make tests be more descriptive, cause BDD can provide more context behind the feature
     so each test will be responsible to have more clearly what business value we are testing
     */
    
    ///`BR 01.` Remember to display a loading state while the content is being fetched.
    func test_ShowLoadingStateWhileContentIsBeingFetched() throws {
        
        let sut = createKeyboardContentMock()
        
        let inspectedName = try sut
            .inspect()
            .find(LoadingView.self).actualView()
            .inspect()
            .find(text: Localized.Default.SearchingContent).string()
        
        XCTAssertEqual(Localized.Default.SearchingContent, inspectedName)
    }
    
    /// `BR 02.` The API will randomly (about 1/5 times) return an error with status code 500 and json data { error: 'Random Error' }. Make sure you handle this.
    func test_ShowErrorViewWhenApiReturnAnError() throws {
        
        let sut = createKeyboardRandomErrorMock()
        
        let exp = sut.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().contentViewState, .failure(HTTPError.randomError.errorMessage))
            XCTAssertNotNil(try view.actualView().inspect().find(ErrorView.self))
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    /// `BR 03.` When you tap the first time, the app should output the first (index == 0) piece of attached content.
    func test_ShowFirstContentWhenTapTheFirstTime() throws {
        
        let documentProxyMock = DocumentProxyMock()
        
        let keyboardContentMock = getMockKeyboardContent()
        
        let sut = createKeyboardConbtentWithDocumentProxyMock(content: keyboardContentMock, documentProxy: documentProxyMock)
        
        let exp = sut.inspection.inspect { view in
            
            let keyboardContentView = try view
                .actualView()
                .inspect()
                .find(KeyboardContentView.self)
                .actualView()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, String())
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[0].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[0].content[0])
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
}

private func createKeyboardConbtentWithDocumentProxyMock(content: [KeyboardContent], documentProxy: DocumentProxyCallbackProtocol) -> KeyboardView<DefaultKeyboardViewModel> {
    let keyboardResponse = KeyboardContentResponse(content: content)
    let useCaseDummy = DefaultGetContentUseCase(repository: KeyboardRepositoryStub(result: keyboardResponse))
    let viewModel = DefaultKeyboardViewModel(useCase: useCaseDummy, documentProxyCallback: documentProxy)
    return KeyboardView(keyboardViewModel: viewModel)
}

private func createKeyboardContentMock(content: [KeyboardContent] = getMockKeyboardContent()) -> KeyboardView<DefaultKeyboardViewModel> {
    let keyboardResponse = KeyboardContentResponse(content: getMockKeyboardContent())
    let useCaseDummy = DefaultGetContentUseCase(repository: KeyboardRepositoryStub(result: keyboardResponse))
    let viewModel = DefaultKeyboardViewModel(useCase: useCaseDummy, documentProxyCallback: DocumentProxyMock())
    return KeyboardView(keyboardViewModel: viewModel)
}

private func createKeyboardRandomErrorMock() -> KeyboardView<DefaultKeyboardViewModel> {
    let useCaseDummy = DefaultGetContentUseCase(repository: KeyboardRepositoryStub(result: .randomError))
    let viewModel = DefaultKeyboardViewModel(useCase: useCaseDummy, documentProxyCallback: DocumentProxyMock())
    return KeyboardView(keyboardViewModel: viewModel)
}

private func getMockKeyboardContent() -> [KeyboardContent] {
    return [KeyboardContent(id: "1", displayText: "greetings", content: ["hey","what's up?","how's it going?"]),
            KeyboardContent(id: "2", displayText: "banter", content: ["what are your plans this weekend?","how do you feel about marvel movies?","what's your favorite day of the week?"]),
            KeyboardContent(id: "3", displayText: "farewell", content: ["goodbye","talk to you later!","peace out"])]
}

private class KeyboardRepositoryStub: KeyboardRepository {
    
    private let result: AnyPublisher<KeyboardContentResponse, HTTPError>
    
    init(result: KeyboardContentResponse) {
        self.result = .init(Result<KeyboardContentResponse, HTTPError>.Publisher(result))
    }
    init(result: HTTPError) {
        self.result = .init(Fail<KeyboardContentResponse, HTTPError>(error: result))
    }
    
    func getContent() -> AnyPublisher<KeyboardContentResponse, HTTPError> {
        return result
    }
}

//private class DocumentProxyDummy: DocumentProxyCallbackProtocol {
//    func insertText(_ text: String) {}
//    func switchToNextInputMode() {}
//}

private class DocumentProxyMock: UIInputViewController, DocumentProxyCallbackProtocol {
    func insertText(_ text: String) {
        clearInputText()
        textDocumentProxy.insertText(text)
    }
    func switchToNextInputMode() {}
    
    private func clearInputText() {
        if let word:String = self.textDocumentProxy.documentContextBeforeInput {
            for _: Int in 0 ..< word.count {
                self.textDocumentProxy.deleteBackward()
            }
        }
    }
}
