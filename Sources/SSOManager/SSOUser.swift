//
//  SSOUser.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 24/08/2021.
//

public struct SSOUser {
    
    public let id: String?
    public let name: String?
    public let firstName: String?
    public let familyName: String?
    public let email: String?
    public let ssoToken: String?
    
    init(id: String?,
         name: String?,
         firstName: String? = nil,
         familyName: String? = nil,
         email: String?,
         ssoToken: String?) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.familyName = familyName
        self.email = email
        self.ssoToken = ssoToken
    }
    
    init(name: String?,
         email: String?,
         ssoToken: String?) {
        self.init(id: nil, name: name, email: email, ssoToken: ssoToken)
    }
}
