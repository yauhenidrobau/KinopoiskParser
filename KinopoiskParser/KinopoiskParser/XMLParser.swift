//
//  XMLParser.swift
//  KinopoiskParser
//
//  Created by Admin on 01.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

@objc protocol XMLParserDelegate {
    func xmlParserDidFinishParsing(items: [Dictionary<String,String>]?, error: NSError?) -> Void
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
   //MARK: Properties
    static let sharedInstance = XMLParser()
    
    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var  titleFeed = ""
    var descriptionFeed = ""
    var pubDateFeed = ""
    var linkFeed :[String] = []
    var urlImage = ""
    var xmlParserDelegate : NSXMLParserDelegate?
    var parserDelegate : XMLParserDelegate?

    
    //MARK: Lifestyle
   
    func parseData(data: NSData) -> Void{
        let parser = NSXMLParser.init(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
            self.currentElement = elementName
            if (elementName as NSString).isEqualToString("item") {
                
                currentDataDictionary = Dictionary<String,String>()
                titleFeed = ""
                descriptionFeed = ""
                pubDateFeed = ""
                linkFeed = []
                urlImage = ""
            }
        }
        
        func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            
            
            //save data
            if (elementName as NSString).isEqualToString("item") {
                
                if titleFeed != "" {
                    currentDataDictionary["title"] = titleFeed
                    
                }
                
                if !linkFeed.isEmpty {
                    currentDataDictionary["link"] = linkFeed[0]
                }
                
                if descriptionFeed != "" {
                    currentDataDictionary["description"] = descriptionFeed
                }
                
                if pubDateFeed != "" {
                    currentDataDictionary["pubDate"] = pubDateFeed
                }
                
                if urlImage != ""{
                    currentDataDictionary["url"] = urlImage
                }
                arrParsedData.append(currentDataDictionary)
            }
        }
        
        
        
        func parser(parser: NSXMLParser, foundCharacters string: String) {
            
            if currentElement == "title" {
                titleFeed += string
            } else if currentElement == "description" {
                descriptionFeed += string
            } else if currentElement == "link" && linkFeed.isEmpty{
                linkFeed.append(string)
            } else if currentElement == "pubDate" {
                pubDateFeed += string
            } else if currentElement == "url" && urlImage.isEmpty {
                urlImage += string
            }
        }
        
    

    
    
    // MARK: NSXMLParserDelegate
    func parserDidEndDocument(parser: NSXMLParser) {
        parserDelegate?.xmlParserDidFinishParsing(arrParsedData, error: nil)
       
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.description)
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print(validationError.description)
    }
    
    
}
