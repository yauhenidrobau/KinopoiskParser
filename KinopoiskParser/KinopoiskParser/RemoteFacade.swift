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
        case Success(items:NSData) // не уверен,в чем там приходит результат
        case OfflineError
        case UnexpectedError(error:NSError?)
    }
    
    func loadData(dataURL: String, callback:(result:DataLoadingResult) -> Void) -> Void {
        // тут ты загружаешь данные
        
        
        
    }
    
    
}
