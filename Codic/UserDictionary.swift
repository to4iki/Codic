//
//  UserDictionary.swift
//  Codic
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

extension Codic {
    
    /**
    *  User's Dictionary
    */
    public struct UserDictionary {
        
        let id: Int
        let name: String
        let wordsCount: Int
        let shared: Bool
//        let createdOn: NSDate
        let owner: User
        
        /**
        initializer
        
        :param: dictionary json object
        
        :returns: self
        */
        init?(dictionary: NSDictionary) {
            if
                let id = dictionary["id"] as? Int,
                let name = dictionary["name"] as? String,
                let wordsCount = dictionary["words_count"] as? Int,
                let shared = dictionary["shared"] as? Bool,
                let ownerDictionary = dictionary["owner"] as? NSDictionary,
                let user = User(dictionary: ownerDictionary)
            {
                self.id = id
                self.name = name
                self.wordsCount = wordsCount
                self.shared = shared
                self.owner = user
            } else {
                return nil
            }
        }
    }
}

/// MARK: - Printable
extension Codic.UserDictionary: Printable {
    public var description: String {
        return "UserDictionary: id: \(id), name: \(name), words_count: \(wordsCount), owner: \(owner.description)"
    }
}
