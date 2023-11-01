//
//  CocoaPresentationTests.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 30/10/23.
//

import XCTest
@testable import CocoaPresentation

class UserAPIStub: UserAPI {
    override func getUsers() -> [User] {
        [User(name: "User1"), User(name: "User2"), User(name: "User3")]
    }
}

class UserAPISpy: UserAPI {
    
    private(set) var getUsersCalledCount = 0
    var getUsersCalledToBeReturned = [User]()
    
    override func getUsers() -> [User] {
        getUsersCalledCount += 1
        return getUsersCalledToBeReturned
    }
}
