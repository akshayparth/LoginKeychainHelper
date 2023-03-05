//
//  SecureCredentials.swift
//  Copyright Devarshi Kulshreshtha (devarshi.kulshreshtha@gmail.com)
//

import Foundation

public struct SecureCredentials : Codable {
    public var userId: String
    public var userName: String
    public var userPassword: String?
    public var firebaseUID: String
    public var gToken: String?
    public var fbToken: String?
    public var appleToken: String?

    
    
    public func data() throws -> Data{
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        }
        catch {
            throw error
        }
    }
    
    public init(userId: String, userName: String, userPassword: String?, firebaseUID: String,gToken:String?,fbToken:String?,appleToken:String?) {
        self.userId = userId
        self.userName = userName
        self.firebaseUID = firebaseUID
        if let gToken = gToken {
             self.gToken = gToken
        }
        if let fbToken = fbToken {
             self.fbToken = fbToken
        }
        if let userPassword = userPassword {
             self.userPassword = userPassword
        }
        if let appleToken = appleToken {
            self.appleToken = appleToken
        }
        
    }
    
    public init(data: Data) throws {
        do {
            let decoder = JSONDecoder()
            self = try decoder.decode(SecureCredentials.self, from: data)
        }
        catch {
            throw error
        }
    }
}
