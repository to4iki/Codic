//
//  User.swift
//  Codic
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

extension Codic {
    
    /**
    *  Codic User Account
    */
    public struct User {
        
        /// User id
        let id: Int
        /// User name
        let name: String
        
        /**
        Initializer
        
        :param: dictionary json object
        
        :returns: self
        */
        init?(dictionary: NSDictionary) {
            if
                let id = dictionary["id"] as? Int,
                let name = dictionary["name"] as? String
            {
                self.id = id
                self.name = name
            } else {
                return nil
            }
        }
    }
}

/// MARK: - Printable
extension Codic.User: Printable {
    public var description: String {
        return "User(id: \(id), name: \(name))"
    }
}
