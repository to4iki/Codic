//
//  Request.swift
//  Codic
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

/**
*  CodicAPI Request
*/
public class Request<T>: NSObject {
    
    /// concrete data task
    private var task: NSURLSessionDataTask?
    /// on resolve event
    private var onResolveHandler: ((T) -> Void)?
    /// on reject event
    private var onRejectHandler: ((NSError) -> Void)?
    
    public override init() {
        super.init()
    }
    
    func resolve(value: T) {
        onResolveHandler?(value)
    }
    
    func reject(error: NSError) {
        onRejectHandler?(error)
    }
    
    public func resolve(handler: (T) -> Void) -> Request<T> {
        onResolveHandler = handler
        return self
    }
    
    public func reject(handler: (NSError) -> Void) -> Request<T> {
        onRejectHandler = handler
        return self
    }
    
    public func fold(#resolve: (T) -> Void, reject: (NSError) -> Void) -> Request<T> {
        onResolveHandler = resolve
        onRejectHandler = reject
        return self
    }
    
    public func resume() {
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    func setDataTaskWithSession(session: NSURLSession, url: NSURL, resolveHandler: (AnyObject?) -> Void) {
        task = session.dataTaskWithURL(url) { [weak self] data, URLResponse, connectionError in
            if let connectionError = connectionError {
                self?.reject(connectionError)
                return
            }
            
            var serializeError: NSErrorPointer = nil
            let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: serializeError)!
            
            if serializeError != nil {
                self?.reject(serializeError.memory!)
                return
            }
            
            println("===")
            println(json.description)
            
            resolveHandler(json)
        }
    }
}