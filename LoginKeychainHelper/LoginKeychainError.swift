//
//  LoginKeychainError.swift
//  Copyright Devarshi Kulshreshtha (devarshi.kulshreshtha@gmail.com)
//

import Foundation

public enum LoginKeychainError: Error {
    case saveFailure
    case userDoesNotExist
    case dataNotFound
    case userDeletionFailed
}

extension LoginKeychainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .saveFailure:
            return NSLocalizedString("Credentials could not be saved in Keychain. Please try again!", comment: "")
        case .userDoesNotExist:
            return NSLocalizedString("Credentials for user does not exist in Keychain!", comment: "")
        case .dataNotFound:
            return NSLocalizedString("Data does not found for user in Keychain!", comment: "")
        case .userDeletionFailed:
            return NSLocalizedString("Data for user could not be deleted from Keychain!!", comment: "")
        }
    }
}
