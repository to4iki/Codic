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
    
    /// Concrete data task
    private var task: NSURLSessionDataTask?
    /// Complete event
    private var onSuccessHandler: ((T) -> Void)?
    /// Failure event
    private var onFailureHandler: ((NSError) -> Void)?
    
    /// Returns whether the request has already been completed with a success or failure
    public var isComplete: Bool {
        return onSuccessHandler != nil && onFailureHandler != nil
    }
    
    public override init() {
        super.init()
    }
    
    func resolve(value: T) {
        onSuccessHandler?(value)
    }
    
    func reject(error: NSError) {
        onFailureHandler?(error)
    }
    
    public func onSuccess(handler: (T) -> Void) -> Request<T> {
        onSuccessHandler = handler
        return self
    }
    
    public func onFailure(handler: (NSError) -> Void) -> Request<T> {
        onFailureHandler = handler
        return self
    }
    
    public func onComplete(#resolve: (T) -> Void, reject: (NSError) -> Void) -> Request<T> {
        onSuccessHandler = resolve
        onFailureHandler = reject
        return self
    }
    
    /**
    Cancels the task
    */
    public func cancel() {
        task?.cancel()
    }
    
    /**
    Resumes the task, if it is suspended
    */
    public func resume() {
        task?.resume()
    }
    
    /**
    Temporarily suspends a task
    */
    public func suspend() {
        task?.suspend()
    }
    
    func setDataTaskWithSession(session: NSURLSession, url: NSURL, successHandler: (AnyObject?) -> Void) {
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
            
            successHandler(json)
        }
    }
}
