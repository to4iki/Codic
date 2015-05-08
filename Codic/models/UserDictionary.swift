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
    public struct UserDictionary: Serializable {
        
        /// User dictionary id
        public let id: Int
        /// User dictionary name
        public let name: String
        /// Count
        public let wordsCount: Int
        /// Is share
        public let shared: Bool
        /// Created date
        public let createdOn: NSDate
        /// User
        public let owner: User
        
        /// formatter
        private static var dateFormatter: NSDateFormatter {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return formatter
        }
        
        /**
        Initializer
        
        :param: dictionary json object
        
        :returns: self
        */
        public init?(dictionary: NSDictionary) {
            if
                let id = dictionary["id"] as? Int,
                let name = dictionary["name"] as? String,
                let wordsCount = dictionary["words_count"] as? Int,
                let shared = dictionary["shared"] as? Bool,
                let createdOnTimestamp = dictionary["created_on"] as? String,
                let ownerDictionary = dictionary["owner"] as? NSDictionary,
                let user = User(dictionary: ownerDictionary)
            {
                self.id = id
                self.name = name
                self.wordsCount = wordsCount
                self.shared = shared
                self.createdOn = Codic.UserDictionary.dateFormatter.dateFromString(createdOnTimestamp) ?? NSDate()
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
        return "UserDictionary(id: \(id), name: \(name), wordsCount: \(wordsCount), createdOn :\(createdOn), owner: \(owner.description))"
    }
}
