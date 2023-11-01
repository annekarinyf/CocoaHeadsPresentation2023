//
//  LoginUseCaseTests2.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

import XCTest
@testable import CocoaPresentation

final class LoginUseCaseTests2: XCTestCase {
    
    func test_givenUserIsAlreadyLoggedIn_whenExecute_shouldNotSetNewLoginSession() {
        let (sut, getUserSessionSpy, setUserSessionSpy) = makeSUT()
        getUserSessionSpy.isLoggedInToBeReturned = true
        
        sut.execute(username: .random(), password: .random())
        
        XCTAssertEqual(setUserSessionSpy.logInCalledCount, 0)
    }
    
    func test_givenUserIsNotLoggedIn_whenExecute_shouldSetNewLoginSession() {
        let (sut, getUserSessionSpy, setUserSessionSpy) = makeSUT()
        getUserSessionSpy.isLoggedInToBeReturned = false
        
        let username = String.random()
        let password = String.random()
        
        sut.execute(username: username, password: password)
        
        XCTAssertEqual(setUserSessionSpy.logInCalledCount, 1)
        XCTAssertEqual(setUserSessionSpy.logInUsernamePassed, username)
        XCTAssertEqual(setUserSessionSpy.logInPasswordPassed, password)
    }
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (LoginUseCase, GetUserSessionSpy, SetUserSessionSpy) {
        let getUserSession = GetUserSessionSpy()
        let setUserSession = SetUserSessionSpy()
        let sut = LoginUseCase(getUserSession: getUserSession, setUserSession: setUserSession)
        
        trackForMemoryLeaks(getUserSession, file: file, line: line)
        trackForMemoryLeaks(setUserSession, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, getUserSession, setUserSession)
    }
}

