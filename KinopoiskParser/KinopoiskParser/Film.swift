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

   // let parser = XMLParser.sharedInstance
    static let sharedInstance = Film()
    var fetchedResultsController: NSFetchedResultsController!
    
    
      convenience init(){
        
       
        // Создание нового объекта
        self.init(entity: CoreDataManager.instance.entityForName("Film"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
    
    func setup() -> Void {
        
        let parser = XMLParser()
        let entityDescription = NSEntityDescription.entityForName("Film", inManagedObjectContext: self.managedObjectContext!)
        let managedObject = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        parser.loadData()
        
       // parser.beginParsing(Constants.url!)
        
        // Set value to Context
        for count in parser.arrParsedData{
            let currentDictionary = count as Dictionary<String,String>
          //let managedObject = Film()
            
            managedObject.setValue(currentDictionary["title"], forKey: "titleFeed" )
            managedObject.setValue(currentDictionary["description"], forKey: "descriptionFeed" )
            managedObject.setValue(currentDictionary["pubDate"], forKey: "pubDateFeed" )
            managedObject.setValue(currentDictionary["link"], forKey: "linkFeed" )
            //managedObjectsetValue(currentDictionary["urlImage"],forKey: UIImagePNGRepresentation(UIImage(named: currentDictionary["urlImage"] !)))
            
            // SaveData
           self.saveFilms()
        }
           // CoreDataManager.instance.saveContext()
            
            // Извление записей
          /*
*/
       
    }
  
    func saveFilms() {
        
            if managedObjectContext!.hasChanges {
                do {
                    try managedObjectContext!.save()
                } catch {
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
    }
    func getFilms(){
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
    */
}

