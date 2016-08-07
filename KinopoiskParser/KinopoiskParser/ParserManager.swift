//
//  ParserManager.swift
//  KinopoiskParser
//
//  Created by Admin on 06.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class ParserManager: NSObject {
    
   static let sharedInstance = ParserManager()

    var callback: ((result:ParserManagerResult) -> Void)?
    
    enum ParserManagerResult {
        case UnexpectedError(error: NSError?)
        case  Succcess(items: [Dictionary<String,String>])
        
    }
    
    func parseXmlData(data: NSData, callback: (result:ParserManagerResult) -> Void) -> Void {
        self.callback = callback
        let parser = XMLParser()
        parser.parserDelegate = self
        parser.parseData(data)
    }
}
    extension ParserManager: XMLParserDelegate {
        
        func xmlParserDidFinishParsing(items: [Dictionary<String, String>]?, error: NSError?) {
            guard let callback_ = callback else { return }
            if let err = error {
                callback_(result: .UnexpectedError(error: err))
            } else if let items_ = items {
                callback_(result: .Succcess(items: items_))
            }
        }
    }
