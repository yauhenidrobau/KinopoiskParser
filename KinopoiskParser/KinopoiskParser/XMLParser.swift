//
//  XMLParser.swift
//  KinopoiskParser
//
//  Created by Admin on 01.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreData

@objc protocol XMLParserDelegate {
    func parsingWasFinished()
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var film: [Film] = []
    
    var arrParsedData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentElement = ""
    
    var foundCharacters = ""
    var  titleFeed = ""
    var descriptionFeed = ""
    var pubDateFeed = ""
    var linkFeed :[String] = []
    
    var urlImage = ""
    
    var delegate : XMLParserDelegate?
  
    
    func beginParsing(rssURL: NSURL) {
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser?.delegate = self
        parser?.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
       // if(elementName == "item"){
        
        
            currentElement = elementName
        if (elementName as NSString).isEqualToString("item") {
            
            currentDataDictionary = Dictionary<String,String>()
           titleFeed = ""
            descriptionFeed = ""
            pubDateFeed = ""
            linkFeed = []
            urlImage = ""
        }
       // }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
       
        //save data
        if (elementName as NSString).isEqualToString("item") {
            //  if(!foundCharacters.isEmpty)&&(foundCharacters != "\n"){
        
        
        if titleFeed != "" {
            currentDataDictionary["title"] = titleFeed
            
        }
        
        if !linkFeed.isEmpty {
            foundCharacters = (foundCharacters as NSString).substringFromIndex(0)
            currentDataDictionary["link"] = linkFeed[0]
        }
            
        if descriptionFeed != "" {
            currentDataDictionary["description"] = descriptionFeed
        }
            
        if pubDateFeed != "" {
            currentDataDictionary["pubDate"] = pubDateFeed
        }
            
        if urlImage != ""{
            
            foundCharacters = (foundCharacters as NSString).substringFromIndex(0)
            currentDataDictionary["url"] = urlImage
        }
          // foundCharacters = ""
        
            // save in CoreData
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                film = NSEntityDescription.insertNewObjectForEntityForName("Film", inManagedObjectContext: managedObjectContext) as! Film
                
                film.titleFeed = currentDictionary["title"]
                film.descriptionFeed = currentDictionary["description"]
                film.pubDateFeed = currentDictionary["pubDate"]
                film.linkFeed = currentDictionary["link"]
              //  if let filmImageNews = cell.imageNewsView.image {
                    film.urlImage = UIImagePNGRepresentation(filmImageNews)
                    //self.imageView.sd_setImageWithURL(self.imageURL)
              //  }
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                    //return
                }
            }
            arrParsedData.append(currentDataDictionary)
            //  }
        }
    }

    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
       // if currentElement == "item"{
        if currentElement == "title" {
            titleFeed += string
        } else if currentElement == "description" {
            descriptionFeed += string
        } else if currentElement == "link" && linkFeed.isEmpty{
            linkFeed.append(string)
        } else if currentElement == "pubDate" {
            pubDateFeed += string
        } else if currentElement == "url" {
            urlImage += string
        }
      //  }
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.parsingWasFinished()
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.description)
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print(validationError.description)
    }
    
    
}
