//
//  keysCustomKeyboardChallengeTests.swift
//  keysCustomKeyboardChallengeTests
//
//  Created by Raphael Oliveira on 27/07/22.
//

import XCTest
import Combine
import ViewInspector

@testable import keysCustomKeyboardChallenge
import SwiftUI

class KeysChallengeRequirementsTests: XCTestCase {
    
    /**
     `CR (Challenge Requirement)` represents our business requrements, so we will use `BDD (Behaviour Driven Development)` approach
     to make tests be more descriptive, cause BDD can provide more context behind the feature so each test will be responsible to have more clearly what business value we are testing
     */
    
    ///`CR 01.` Remember to display a loading state while the content is being fetched.
    func test_ShowLoadingStateWhileContentIsBeingFetched() throws {
        
        let sut = createKeyboardContentMock()
        
        let inspectedName = try sut
            .inspect()
            .find(LoadingView.self).actualView()
            .inspect()
            .find(text: Localized.Default.SearchingContent).string()
        
        XCTAssertEqual(Localized.Default.SearchingContent, inspectedName)
    }
    
    /// `CR 02.` The API will randomly (about 1/5 times) return an error with status code 500 and json data { error: 'Random Error' }. Make sure you handle this.
    func test_ShowErrorViewWhenApiReturnAnError() throws {
        
        let sut = createKeyboardRandomErrorMock()
        
        let exp = sut.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().contentViewState, .failure(HTTPError.randomError.errorMessage))
            XCTAssertNotNil(try view.actualView().inspect().find(ErrorView.self))
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    /// `CR 03.` Tapping each button should output its content to the text input
    /// When you tap the first time, the app should output the first (index == 0) piece of attached content.
    /// When you tap the second time, it should output the second piece, etc
    func test_ShowSpecificContentWhenTapSpecificNumbersOfTimes() throws {
        
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
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[0].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[0].content[1])
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[0].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[0].content[2])
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    /// `CR 04.` When you've reached the last piece of content, tapping again should cycle back to the beginning
    func test_ShowFirstContentAgainWhenTapButtonAfterReachedLastContent() throws {
        
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
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[1].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[1].content[0])
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[1].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[1].content[1])
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[1].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[1].content[2])
            
            try keyboardContentView.inspect().find(button: keyboardContentMock[1].displayText.capitalized).tap()
            
            XCTAssertEqual(documentProxyMock.textDocumentProxy.documentContextBeforeInput, keyboardContentMock[1].content[0])
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    /// `CR 05.` Make sure to include a button to exit your custom keyboard and take the user back to the default keyboard
    func test_ShowExitButtonToChangeInputType() throws {
        
        let sut = createKeyboardContentMock()
        
        let exp = sut.inspection.inspect { view in
            XCTAssertNotNil(try view.actualView().inspect().find(button: Localized.Default.Exit))
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
}

class KeysChallengeAdditinalRequirementsTests: XCTestCase {
    
    /// `CR 06.` Long-press on a button show's a popup list with all of the content options.
    /// Selecting one should output it to the text input
    func test_ShowPopupListWhenLongPressContentButton() throws {
        
        /*
         let keyboardContentMock = getMockKeyboardContent()
         
         let sut = createKeyboardConbtentWithDocumentProxyMock(content: keyboardContentMock, documentProxy: DocumentProxyMock())
         
         let exp = sut.inspection.inspect { view in
         
         let keyboardContentView = try view
         .actualView()
         .inspect()
         .find(KeyboardContentView.self)
         .actualView()
         
         let button = try keyboardContentView.inspect().find(button: keyboardContentMock[1].displayText.capitalized)//.gesture(LongPressGesture())
         
         }
         
         ViewHosting.host(view: sut)
         wait(for: [exp], timeout: 0.1)
         */
    }
    
}

private func createKeyboardConbtentWithDocumentProxyMock(content: [KeyboardContent], documentProxy: DocumentProxyCallbackProtocol) -> KeyboardView<DefaultKeyboardViewModel> {
    let keyboardResponse = KeyboardContentResponse(content: content)
    let useCaseDummy = DefaultGetContentUseCase(repository: KeyboardRepositoryStub(result: keyboardResponse))
    let viewModel = DefaultKeyboardViewModel(useCase: useCaseDummy, documentProxyCallback: documentProxy)
    return KeyboardView(keyboardViewModel: viewModel)
}

private func createKeyboardContentMock() -> KeyboardView<DefaultKeyboardViewModel> {
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
