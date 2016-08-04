//
//  Film.swift
//  KinopoiskParser
//
//  Created by Admin on 02.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Film : NSManagedObject {
    /*var titleFeed = ""
    var descriptionFeed = ""
    var pubDateFeed = ""
    var linkFeed [String] = []
    var urlImage = ""
*/

    let parser = XMLParser.sharedInstance
    static let sharedInstance = Film()
    var const = Constants()
    var fetchedResultsController: NSFetchedResultsController!
    
    
      convenience init(){
        
       
        // Создание нового объекта
        self.init(entity: CoreDataManager.instance.entityForName("Film"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Создание нового объекта
        
        let parser = XMLParser()
        let NewsURL = Constants()
        parser.beginParsing(NewsURL.url!)
        
        // Установка значения атрибута
        for count in parser.arrParsedData{
            let currentDictionary = count as Dictionary<String,String>
            let managedObject = Film()
            
            managedObject.titleFeed = currentDictionary["title"]
            managedObject.descriptionFeed = currentDictionary["description"]
            managedObject.pubDateFeed = currentDictionary["pubDate"]
            managedObject.linkFeed = currentDictionary["link"]
            
            managedObject.urlImage = UIImagePNGRepresentation(UIImage(named: currentDictionary["urlImage"]!)!)
            
            // Запись объекта
            CoreDataManager.instance.saveContext()
            
            // Извление записей
            let fetchRequest = NSFetchRequest(entityName: "Film")
            do {
                let results = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest)
                for result in results as! [Film] {
                    print("name - \(result.titleFeed!)")
                }
            } catch {
                print(error)
            }
            
        }
        return true
    }
   /*
    func showData(){
        var fetchRequest = NSFetchRequest(entityName: "Film")
        var sortDescriptor = NSSortDescriptor(key: "titleNews", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
    
        if let manageObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manageObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print(error)
            }
        }
    }
    
    func saveData(){
        
    if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
        sharedInstance.
        sharedInstance = NSEntityDescription.insertNewObjectForEntityForName("Film", inManagedObjectContext: managedObjectContext) as! Film
        
        sharedInstance.titleFeed =  currentDictionary["title"]
        sharedInstance.descriptionFeed = currentDictionary["description"]
        sharedInstance.pubDateFeed = currentDictionary["pubDate"]
        sharedInstance.linkFeed = currentDictionary["link"]
        //  if let filmImageNews = cell.imageNewsView.image {
        sharedInstance.urlImage = UIImagePNGRepresentation(filmImageNews)
        //self.imageView.sd_setImageWithURL(self.imageURL)
        //  }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
            //return
        }
    }
    }
*/

}

