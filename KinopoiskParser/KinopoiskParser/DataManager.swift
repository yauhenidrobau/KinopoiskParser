//
//  DataManager.swift
//  KinopoiskParser
//
//  Created by Admin on 07.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class DataManager:  NSObject {
    static let instance = DataManager()
    
    func updateData() -> Void {
        RemoteFacade.sharedInstance.loadData(Constants.url) { (result) in
            switch result {
            case .OfflineError:
                break
                
            case .UnexpectedError(error: let error):
                break
            case .Success(items: let xmlData):
                guard let data = xmlData else {return}
                ParserManager.sharedInstance.parseXmlData(data, callback: { (result) in
                    switch result {
                    
                    case .Succcess(items: let items):
                       
                        CoreDataManager.instance.saveFilms(items)
                        break
                        
                    case .UnexpectedError(error: let error):
                        break
                    }
                })
            }
        }
    }
}