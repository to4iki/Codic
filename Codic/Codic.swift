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
        
        /// Access key
        private let accessKey: String
        /// Session
        private let URLSession = NSURLSession.sharedSession()
        /// API Endpoint
        static let endPoint: String = "https://api.codic.jp"
        
        /**
        Initializer
        
        :param: accessKey api access_key
        
        :returns: self
        */
        public init(accessKey: String) {
            self.accessKey = accessKey
        }
        
        /// MARK: - URL Builder
        
        /**
        Building Request URL
        
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
    
    /**
    Translate naming
    https://next.codic.jp/docs/api#engine
    
    :param: text         japanies text
    :param: dictionaryId dictionary id
    :param: casing       translate case
    :param: acronymStyle translate style
    :param: decoding     valid decoding
    
    :returns: Request<Codic.Translation>
    */
    public func translate(text: String, dictionaryId: String, casing: Codic.Casing? = nil, acronymStyle: Codic.AcronymStyle? = nil, decoding: Bool = true) -> Request<Codic.Translation> {
        
        func buildParameters() -> [String:AnyObject] {
            var params: [String:AnyObject] = [
                "access_key": accessKey,
                "text": text,
                "dictionary_id": dictionaryId,
                "decoding": decoding.description
            ]
            if let casing = casing?.rawValue {
                params["casig"] = casing
            }
            if let acronymStyle = acronymStyle?.rawValue {
                params["acronym_style"] = acronymStyle
            }
            
            return params
        }
        
        let request = Request<Codic.Translation>()
        let url = buildURL(
            "/v1/engine/translate.json",
            parameters: buildParameters()
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
    Fetch user dictionary list
    https://next.codic.jp/docs/api#user_dictionaries
    
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
    Fetch user dictionary
    https://next.codic.jp/docs/api#user_dictionary
    
    :param: id dictionary id
    
    :returns: Request<Codic.Dictionary>
    */
    public func fetchUserDictionary(id: Int) -> Request<Codic.UserDictionary> {
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
    
    /// Lookup default count
    static let defaultLookupCount = 10
    
    /**
    Lookup CED head word
    https://next.codic.jp/docs/api#ced_lookup
    
    :param: query string
    :param: count max count(default 10)
    
    :returns: Request<[Codic.CodicEnglishDictionary.HeadWord]>
    */
    public func lookup(query: String, count: Int = Codic.Client.defaultLookupCount) -> Request<[Codic.CodicEnglishDictionary.HeadWord]> {
        let request = Request<[Codic.CodicEnglishDictionary.HeadWord]>()
        let url = buildURL(
            "/v1/ced/lookup.json",
            parameters: [
                "access_key": accessKey,
                "query": query,
                "count": count
            ]
        )
        
        request.setDataTaskWithSession(URLSession, url: url) { object in
            if let dictionaries = object as? [NSDictionary] {
                var result: [Codic.CodicEnglishDictionary.HeadWord] = []
                for dictionary in dictionaries {
                    if let headWord = Codic.CodicEnglishDictionary.HeadWord(dictionary: dictionary) {
                        result.append(headWord)
                    }
                }
                request.resolve(result)
            }
        }
        
        return request
    }
}

/// MARK: - GET /v1/ced/entries/:id.json
extension Codic.Client {
    
    /**
    Fetch CED entry
    https://next.codic.jp/docs/api#ced_entry
    
    :param: id CED id
    
    :returns: Request<[Codic.CodicEnglishDictionary.Entry]>
    */
    public func fetchEntry(id: Int) -> Request<Codic.CodicEnglishDictionary.Entry> {
        let request = Request<Codic.CodicEnglishDictionary.Entry>()
        let url = buildURL(
            "/v1/ced/entries/\(id).json",
            parameters: ["access_key": accessKey]
        )
        
        request.setDataTaskWithSession(URLSession, url: url) { object in
            if let dictionary = object as? NSDictionary {
                if let entry = Codic.CodicEnglishDictionary.Entry(dictionary: dictionary) {
                    request.resolve(entry)
                }
            }
        }
        
        return request
    }
}
