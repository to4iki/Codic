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
        
        /// user id
        let id: Int
        /// user name
        let name: String
        
        /**
        initializer
        
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
        return "User: id: \(id), name: \(name)"
    }
}
