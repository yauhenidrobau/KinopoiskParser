//
//  RemoteFacade.swift
//  KinopoiskParser
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class RemoteFacade: NSObject {
    
    //singleton
    static let sharedInstance = RemoteFacade()

    enum DataLoadingResult {
        case Success(items:NSData?)
        case OfflineError
        case UnexpectedError(error:NSError?)
    }
    
    func loadData(dataURL: String, callback:(result:DataLoadingResult) -> Void) -> Void {
        // load data
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            if let url = NSURL.init(string: dataURL) {
                let xmlData = NSData.init(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue(), {
                callback(result: .Success(items: xmlData))
            
            
            })
            }else {
            dispatch_async(dispatch_get_main_queue(), {
                callback(result: .UnexpectedError(error: NSError(domain: "UnexpectedErrorDomain", code: -666, userInfo: nil)))
            })
            }
        })
    }
}
