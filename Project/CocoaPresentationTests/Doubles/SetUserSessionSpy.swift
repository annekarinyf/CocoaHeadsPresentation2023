//
//  SetUserSessionSpy.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

@testable import CocoaPresentation

final class SetUserSessionSpy: SetUserSession {
    private(set) var logInCalledCount = 0
    var logInUsernamePassed: String?
    var logInPasswordPassed: String?
    func logIn(username: String, password: String) {
        logInCalledCount += 1
        logInUsernamePassed = username
        logInPasswordPassed = password
    }
}
