//
//  GetUserSessionSpy.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

@testable import CocoaPresentation

final class GetUserSessionSpy: GetUserSession {
    private(set) var isLoggedInCalled = false
    var isLoggedInToBeReturned = false
    
    func isLoggedIn() -> Bool {
        isLoggedInCalled = true
        return isLoggedInToBeReturned
    }
}
