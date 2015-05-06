//
//  Translation.swift
//  Codic
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

extension Codic {
    
    /**
    Convert Naming Case
    */
    public enum Casing: String {
        case Camel = "camel"
        case Pascal = "pascal"
        case LowerUnderscore = "lower+underscore"
        case UpperUnderscore = "upper+underscore"
        case Hyphen = "hyphen"
    }
    
    /**
    Acronym Style
    */
    public enum AcronymStyle: String {
        case MSNamingGuidelines = "MS naming guidelines"
        case CamelStrict = "camel strict"
        case Literal = "literal"
    }
    
    /**
    *  Translation Result
    */
    public struct Translation {
        
        /// Success of translate
        public let successful: Bool
        /// Translation resule
        public let translatedText: String
        
        /**
        Initializer
        
        :param: dictionary json object
        
        :returns: self
        */
        public init?(dictionary: NSDictionary) {
            if
                let successful = dictionary["successful"] as? Bool,
                let translatedText = dictionary["translated_text"] as? String {
                    self.successful = successful
                    self.translatedText = translatedText
            } else {
                return nil
            }
        }
    }
}

/// MARK: - Printable
extension Codic.Translation: Printable {
    public var description: String {
        return "Translation(successful: \(successful), translatedText: \(translatedText))"
    }
}