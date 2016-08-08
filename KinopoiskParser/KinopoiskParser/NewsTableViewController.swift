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


class NewsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: Properties
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController("Film", keyForSort: "titleFeed")
    

    //MARK: Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppierance()
        updateData()
        loadData()
        fetchedResultsController.delegate = self
           }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        
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
        guard let cell = cell_ as? NewsTableViewCell else {
            return cell_
        }
        
        if let filmItem = fetchedResultsController.objectAtIndexPath(indexPath) as? Film {
            cell.titleLabel.text = filmItem.titleFeed
            cell.descriptionLabel.text = filmItem.descriptionFeed
        
        }
        return cell
    }
    
     override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.name
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let filmItem =  fetchedResultsController
            .objectAtIndexPath(indexPath) as? Film  else {return}
        performSegueWithIdentifier("detailFilmSegue", sender: filmItem.linkFeed)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? DetailsViewController{
            if let url = sender as? String {
                if let detailUrl = NSURL.init(string: url){
                    destinationVC.newsUrl = detailUrl
                }
            }
        }
    }
    
    
  
    
    //MARK: NSFetchedResultsControllerDelegate
    
    //check if there is some changes in Data Base
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
                let cell = self.tableView.cellForRowAtIndexPath(_newindexPath) as? NewsTableViewCell
                 let filmItem = fetchedResultsController.objectAtIndexPath(_newindexPath) as? Film
                    cell!.titleLabel.text = filmItem!.titleFeed
                    cell!.descriptionLabel.text = filmItem!.descriptionFeed
                tableView.reloadRowsAtIndexPaths([_newindexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
    }
    
    func controller(controller: NSFetchedResultsController, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(
        controller: NSFetchedResultsController,
        didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
        atIndex sectionIndex: Int,
        forChangeType type: NSFetchedResultsChangeType) {
            
            switch type {
            case .Insert:
                let sectionIndexSet = NSIndexSet(index: sectionIndex)
                self.tableView.insertSections(sectionIndexSet, withRowAnimation: UITableViewRowAnimation.Fade)
            case .Delete:
                let sectionIndexSet = NSIndexSet(index: sectionIndex)
                self.tableView.deleteSections(sectionIndexSet, withRowAnimation: UITableViewRowAnimation.Fade)
            default:
                ""
            }
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    private func setAppierance() -> Void {
        // auto re-sizing cell
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
    
    }
    
    private func loadData() -> Void {
       

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print (error)
        }
       

    }
    
    private func updateData() -> Void {
        DataManager.instance.updateData()
    }


}
