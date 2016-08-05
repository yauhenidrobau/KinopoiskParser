//
//  NewsTableViewController.swift
//  KinopoiskParser
//
//  Created by Admin on 01.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class NewsTableViewController: UITableViewController, NSXMLParserDelegate,XMLParserDelegate, NSFetchedResultsControllerDelegate {

    
    //MARK: Properties
    
    var parser = XMLParser()
    let film = Film()
    
    //let FeedEntity = Film.sharedInstance
    var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Film")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //parser.beginParsing(Constants.url!)
       
        film.setup()
        parser.parserDelegate = self
        film.saveFilms()

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print (error)
        }
        
        // auto re-sizing cell
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count > section ? sections[section].numberOfObjects : 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell_ = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        guard let cell = cell_ as? NewsTableViewCell else { // ! - приведение к типу таким образом может привести к крэшу, если вдруг там будет какой-то другой тип, а не тот, что ты ожидаешь
            return cell_
        }
         // почему ты отсюда достаешь урл, а из базы все остальное
        
        if let filmItem = fetchedResultsController.objectAtIndexPath(indexPath) as? Film {
            cell.film?.titleFeed = filmItem.titleFeed // лучше в селле добавить проперти фильм и там просто переопределить сэттэр
            cell.film?.descriptionFeed = filmItem.descriptionFeed
        
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let filmItem =  fetchedResultsController
            .objectAtIndexPath(indexPath) as? Film
        
        let newsLink = filmItem!.linkFeed
        let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idDetailsController") as! DetailsViewController // почему не performSegue ???
        newsViewController.newsUrl = NSURL(string: newsLink!)
        showDetailViewController(newsViewController, sender: self)
    }
    
    
  
    
    //MARK: NSFetchedResultsControllerDelegate
    
    //check if there is some changes ing Data Base
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newindexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newindexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _newindexPath = newIndexPath {
                tableView.deleteRowsAtIndexPaths([_newindexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _newindexPath = newIndexPath {
                tableView.reloadRowsAtIndexPaths([_newindexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func parserDidFinishParsing() {
        self.tableView.reloadData()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

}
