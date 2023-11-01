//
//  LoginUseCase.swift
//  CocoaPresentation
//
//  Created by Anne Freitas on 30/10/23.
//

import Foundation

protocol GetUserSession {
    func isLoggedIn() -> Bool
}

protocol SetUserSession {
    func logIn(username: String, password: String)
}

protocol ValidateUsername {
    func isValid(_ username: String) -> Bool
}

protocol ValidatePassword {
    func isValid(_ password: String) -> Bool
}

final class ValidateCredentialsUseCase {
    private let validateUserName: ValidateUsername
    private let validatePassword: ValidatePassword
    
    init(validateUserName: ValidateUsername, validatePassword: ValidatePassword) {
        self.validateUserName = validateUserName
        self.validatePassword = validatePassword
    }
    
    func execute(username: String, password: String) -> Bool {
        validateUserName.isValid(username) && validatePassword.isValid(password)
    }
}

final class LoginUseCase {
    private let getUserSession: GetUserSession
    private let setUserSession: SetUserSession
    
    init(getUserSession: GetUserSession, setUserSession: SetUserSession) {
        self.getUserSession = getUserSession
        self.setUserSession = setUserSession
    }
    
    func execute(username: String, password: String) {
        guard !getUserSession.isLoggedIn() else { return }
        setUserSession.logIn(username: username, password: password)
    }
}


final class SessionHelper {
    
    private let validateUserName: ValidateUsername
    private let validatePassword: ValidatePassword
    private let getUserSession: GetUserSession
    private let setUserSession: SetUserSession
    
    init(validateUserName: ValidateUsername, validatePassword: ValidatePassword, getUserSession: GetUserSession, setUserSession: SetUserSession) {
        self.validateUserName = validateUserName
        self.validatePassword = validatePassword
        self.getUserSession = getUserSession
        self.setUserSession = setUserSession
    }
    
    func login(username: String, password: String) {
        if validateUserName.isValid(username) && validatePassword.isValid(password) {
            guard !getUserSession.isLoggedIn() else { return }
            
            setUserSession.logIn(username: username, password: username)
        }
    }
    
    func logout(username: String, password: String) {
        // Logout logic
    }
}

