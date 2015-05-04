//
//  Codic.swift
//  Codic
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

/**
*  Codic
*/
public struct Codic {
    
    /**
    *  API Client
    */
    public class Client {
        
        /// access key
        private let accessKey: String
        /// session
        private let URLSession = NSURLSession.sharedSession()
        /// api endpoint
        static let endPoint: String = "https://api.codic.jp"
        
        /**
        initializer
        
        :param: accessKey api access_key
        
        :returns: self
        */
        public init(accessKey: String) {
            self.accessKey = accessKey
        }
        
        /// MARK: - URL Builder
        
        /**
        building Request URL
        
        :param: path       api path
        :param: parameters api parameters
        
        :returns: URL
        */
        private func buildURL(path: String, parameters: [String: AnyObject] = [:]) -> NSURL {
            func buildQueryString() -> String {
                var pairs: [String] = []
                for (key, value) in parameters {
                    let string = (value as? String) ?? "\(value)"
                    let pair = "\(key)=\((string))"
                    pairs.append(pair)
                }
                return "?" + join("&", pairs)
            }
            
            let url = Client.endPoint + path + buildQueryString()
            return NSURL(string: url)!
        }
    }
}

/// MARK: - GET /v1/engine/translate.json
extension Codic.Client {
    
    // TODO
    public func translate() -> Request<Codic.Translation> {
        let request = Request<Codic.Translation>()
        let url = buildURL(
            "/v1/engine/translate.json",
            parameters: [
                "access_key": accessKey,
                "text": "",
                "dictionary_id": "",
                "casing ": "",
                "acronym_style ": "",
                "decoding": ""
            ]
        )
        
        request.setDataTaskWithSession(URLSession, url: url) { object in
            if let dictionary = object as? NSDictionary {
                if let translation = Codic.Translation(dictionary: dictionary) {
                    request.resolve(translation)
                }
            }
        }
        
        return request
    }
}

/// MARK: - GET /v1/user_dictionaries.json
extension Codic.Client {
    
    /**
    fetch user dictionary list
    
    :returns: Request<[Codic.Dictionary]>
    */
    public func fetchUserDictionaries() -> Request<[Codic.UserDictionary]> {
        let request = Request<[Codic.UserDictionary]>()
        let url = buildURL(
            "/v1/user_dictionaries.json",
            parameters: ["access_key": accessKey]
        )
        
        request.setDataTaskWithSession(URLSession, url: url) { object in
            if let dictionaries = object as? [NSDictionary] {
                var result: [Codic.UserDictionary] = []
                for dictionary in dictionaries {
                    if let userDictionary = Codic.UserDictionary(dictionary: dictionary) {
                        result.append(userDictionary)
                    }
                }
                
                request.resolve(result)
            }
        }
        
        return request
    }
}

/// MARK: - GET /v1/user_dictionary/:id.json
extension Codic.Client {
    
    /**
    fetch user dictionary
    
    :param: id dictionary id
    
    :returns: Request<Codic.Dictionary>
    */
    public func fetchUserDictionary(id: String) -> Request<Codic.UserDictionary> {
        let request = Request<Codic.UserDictionary>()
        let url = buildURL(
            "/v1/user_dictionary/\(id).json",
            parameters: ["access_key": accessKey]
        )
        
        request.setDataTaskWithSession(URLSession, url: url) { object in
            if let dictionary = object as? NSDictionary {
                if let userDictionary = Codic.UserDictionary(dictionary: dictionary) {
                    request.resolve(userDictionary)
                }
            }
        }
        
        return request
    }
}

/// MARK: - GET /v1/ced/lookup.json
extension Codic.Client {
}

/// MARK: - GET /v1/ced/entries/:id.json
extension Codic.Client {
}