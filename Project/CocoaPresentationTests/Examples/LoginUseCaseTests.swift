//
//  LoginUseCaseTests.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

import XCTest
@testable import CocoaPresentation

final class LoginUseCaseTests: XCTestCase {
    private let getUserSessionSpy = GetUserSessionSpy()
    private let setUserSessionSpy = SetUserSessionSpy()
    
    private var sut: LoginUseCase {
        LoginUseCase(getUserSession: getUserSessionSpy, setUserSession: setUserSessionSpy)
    }
    
    func test_givenUserIsAlreadyLoggedIn_whenExecute_shouldNotSetNewLoginSession() {
        getUserSessionSpy.isLoggedInToBeReturned = true
        
        sut.execute(username: .random(), password: .random())
        
        XCTAssertEqual(setUserSessionSpy.logInCalledCount, 0)
    }
    
    func test_givenUserIsNotLoggedIn_whenExecute_shouldSetNewLoginSession() {
        getUserSessionSpy.isLoggedInToBeReturned = false
        
        let username = String.random()
        let password = String.random()
        
        sut.execute(username: username, password: password)
        
        XCTAssertEqual(setUserSessionSpy.logInCalledCount, 1)
        XCTAssertEqual(setUserSessionSpy.logInUsernamePassed, username)
        XCTAssertEqual(setUserSessionSpy.logInPasswordPassed, password)
    }
}


