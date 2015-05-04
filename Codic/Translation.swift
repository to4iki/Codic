//
//  Translation.swift
//  Codic
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

extension Codic {
    
    public enum Casing: String {
        case Camel = "camel"
        case Pascal = "pascal"
        case LowerUnderscore = "lower+underscore"
        case UpperUnderscore = "upper+underscore"
        case Hyphen = "hyphen"
    }
    
    public enum AcronymStyle: String {
        case MSNamingGuidelines = "MS naming guidelines"
        case CamelStrict = "camel strict"
        case Literal = "literal"
    }
    
    /**
    *  Translation Result
    */
    public struct Translation {
        
        /// success of translate
        let successful: Bool
        /// translation resule
        let translatedText: String
        
        /**
        initializer
        
        :param: dictionary json object
        
        :returns: self
        */
        init?(dictionary: NSDictionary) {
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
        return "Translation: successful: \(successful), translated_text: \(translatedText)"
    }
}