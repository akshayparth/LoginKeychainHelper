//
//  LoginKeychainManager.swift
//  Copyright Devarshi Kulshreshtha (devarshi.kulshreshtha@gmail.com)
//

import Foundation

public class LoginKeychainManager {
    let kSecClassKey = kSecClass as String
    let kSecAttrAccountKey = kSecAttrAccount as String
    let kSecValueDataKey = kSecValueData as String
    let kSecAttrServiceKey = kSecAttrService as String
    let kSecReturnDataKey = kSecReturnData as String
    let kSecMatchLimitKey = kSecMatchLimit as String
    
    let kSecAttrServiceValue = "LoginKeychainAccess"
    let kSecAttrAccountValue = "LoginCredentials"
    
    public init() { }
    
    public func createKeychainItem(username: String, userId: String, password: String?, firebaseUID: String,gToken:String?,fbToken:String?,appleToken:String?) throws {
        do {
            let secureCredentialsData = try SecureCredentials(userId: userId, userName: username, userPassword: password, firebaseUID: firebaseUID,gToken:gToken,fbToken:fbToken, appleToken: appleToken).data()
            let query: [String: Any] = [kSecClassKey: kSecClassGenericPassword,
                                        kSecAttrAccountKey: kSecAttrAccountValue,
                                        kSecAttrServiceKey: kSecAttrServiceValue,
                                        kSecValueDataKey: secureCredentialsData]
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else { throw LoginKeychainError.saveFailure }
        }
        catch {
            throw error
        }
    }
    
    public func secureCredentials() throws -> SecureCredentials {
        let query: [String: Any] = [kSecClassKey: kSecClassGenericPassword,
                                       kSecAttrAccountKey: kSecAttrAccountValue,
                                       kSecReturnDataKey: kCFBooleanTrue as Any,
                                       kSecAttrServiceKey: kSecAttrServiceValue,
                                       kSecMatchLimitKey: kSecMatchLimitOne]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        guard status == errSecSuccess else { throw LoginKeychainError.userDoesNotExist }
        
        if let dataFound = dataTypeRef as? Data {
            do {
                return try SecureCredentials(data: dataFound)
            }
            catch {
                throw error
            }
        }
        throw LoginKeychainError.dataNotFound
    }
    
    public func deleteCredentials() throws {
        let query: [String: Any] = [kSecClassKey: kSecClassGenericPassword,
                                       kSecAttrAccountKey: kSecAttrAccountValue,
                                       kSecAttrServiceKey: kSecAttrServiceValue]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw LoginKeychainError.userDeletionFailed }
    }
}
