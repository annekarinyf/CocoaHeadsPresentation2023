//
//  LoadUsersTests.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

import Foundation
import XCTest
@testable import CocoaPresentation

protocol UserAPIClient {
    func load(completion: @escaping (([User]) -> Void))
}

protocol LoadUsersUseCase {
    func execute(completion: @escaping (([User]) -> Void))
}

class LoadUsers: LoadUsersUseCase {
    private let userAPIClient: UserAPIClient
    
    init(userAPIClient: UserAPIClient) {
        self.userAPIClient = userAPIClient
    }
    
    func execute(completion: @escaping (([User]) -> Void)) {
        userAPIClient.load { [weak self] users in
            guard self != nil else { return } // Se essa linha for comentada, o teste falha!
            completion(users)
        }
    }
}

class UserAPIClientSpy: UserAPIClient {
    private(set) var apiCalls = [(([User]) -> Void)]()
    
    func load(completion: @escaping (([User]) -> Void)) {
        apiCalls.append(completion)
    }
    
    func complete(with users: [User], at index: Int = 0) {
        apiCalls[index](users)
    }
}

class UserAPIClientSpy2: UserAPIClient {

    private(set) var loadCalled = false
    var loadUsersToBeReturned = [User]()
    
    func load(completion: @escaping (([User]) -> Void)) {
        loadCalled = true
        completion(loadUsersToBeReturned)
    }
}

class LoadUsersTests: XCTestCase {
    func test_givenUsersAPIReturnsUsers_whenExecute_shouldReturnTheSameUsers() {
        let users = [User(name: "User1"), User(name: "User2")]
        
        let usersAPISpy = UserAPIClientSpy2()
        let sut = LoadUsers(userAPIClient: usersAPISpy)
        
        usersAPISpy.loadUsersToBeReturned = users
        
        var expectedUsers = [User]()
        let expectation = self.expectation(description: "Load Users from API")
        
        sut.execute { users in
            expectedUsers = users
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expectedUsers, users)
    }
    
    func test_givenUsersAPI_whenCompleteAfterExecute_shouldNotHaveAnyResultUsers() {
        let usersAPI = UserAPIClientSpy()
        var sut: LoadUsers? = LoadUsers(userAPIClient: usersAPI)
        
        var results = [User]()
        sut?.execute { users in
            results.append(contentsOf: users)
        }
        
        sut = nil
        usersAPI.complete(with: [User(name: "User1")])
        
        XCTAssertTrue(results.isEmpty)
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name
    }
}
