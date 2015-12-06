//
//  DAFetchData.swift
//  Diabetapp
//
//  Created by Clarence Ji on 12/6/15.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import Foundation

enum DAServerError {
    case SeverError(error: NSError)
    case ParseError
    case NoError
}

class DAServer: NSObject {
    
    class func sharedSession() -> DAServer {
        
        var sharedInstance: DAServer!
        var onceToken = dispatch_once_t()
        
        dispatch_once(&onceToken) { () -> Void in
            sharedInstance = DAServer()
        }
        
        return sharedInstance
        
    }
    
    func fetchData(urlString: String, completion: (data: AnyObject?, error: DAServerError) -> Void) {
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if data == nil {
                    
                    completion(data: nil, error: .SeverError(error: error!))
                    return
                    
                }
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    completion(data: json, error: .NoError)
                    
                } catch {
                    completion(data: nil, error: .ParseError)
                }
            })
        }.resume()
        
    }
    
}