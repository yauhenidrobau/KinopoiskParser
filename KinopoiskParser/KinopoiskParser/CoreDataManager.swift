//
//  CoreDataManager.swift
//  KinopoiskParser
//
//  Created by Admin on 04.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    //Singleton
    static let instance = CoreDataManager()
   
    enum FilmError: ErrorType {
        case NoFilms
        
    }
    
    //Entity for Name
    func entityForName (entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entityForName(entityName, inManagedObjectContext: CoreDataManager.instance.managedObjectContext)!
    }

    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = NSBundle.mainBundle().URLForResource("KinopoiskParser", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Film")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func saveFilms(films: [Dictionary<String,String>]) -> Void {
        
        // Set value to Context
        for filmInfo in films {
            guard let filmTitle = filmInfo["title"] else {continue}
            let fetchRequest = NSFetchRequest(entityName: "Film")
            let predicate = NSPredicate(format: "titleFeed == %@", filmTitle)
            fetchRequest.predicate = predicate
            
            do{
                var filmToBeSaved : Film?
                if let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Film]{
                    if fetchResults.count > 0 {
                        if let film_ = fetchResults.first as Film? {
                            filmToBeSaved = film_
                        }
                    }
                 else {
                    //begin create film
                     let entityDescription = NSEntityDescription.entityForName("Film", inManagedObjectContext: managedObjectContext)
                let filmEntity = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext) as? Film
                    filmToBeSaved = filmEntity
                }
                guard let filmToBeSaved_ = filmToBeSaved else {continue}
                //refresh data
                filmToBeSaved_.titleFeed = filmInfo["title"]
                filmToBeSaved_.descriptionFeed = filmInfo["description"]
                filmToBeSaved_.pubDateFeed = filmInfo["pubDate"]
                filmToBeSaved_.linkFeed = filmInfo["link"]
                filmToBeSaved_.urlImage = filmInfo["urlImage"]
}
            } catch FilmError.NoFilms {
                print("No Films")
            } catch (let err) {
            
            }
        
    // SaveData
    saveContext()
        }
    }
    
    
}