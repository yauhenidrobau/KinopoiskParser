//
//  Film.swift
//  KinopoiskParser
//
//  Created by Admin on 02.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import CoreData

class CSDataManager: NSManagedObject {
    @NSManaged var titleFeed: String?
    @NSManaged var descriptionFeed: String?
    @NSManaged var pubDateFeed: String?
    @NSManaged var linkFeed: String?
    @NSManaged var urlImage: NSData?
    
    static let sharedInstance = CSDataManager()
    
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
    // save in CoreData
    if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
        sharedInstance = NSEntityDescription.insertNewObjectForEntityForName("Film", inManagedObjectContext: managedObjectContext) as! CSDataManager
        
        sharedInstance.titleFeed = currentDictionary["title"]
        sharedInstance.descriptionFeed = currentDictionary["description"]
        sharedInstance.pubDateFeed = currentDictionary["pubDate"]
        sharedInstance.linkFeed = currentDictionary["link"]
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
    }


}

