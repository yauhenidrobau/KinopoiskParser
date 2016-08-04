//
//  Film+CoreDataProperties.swift
//  KinopoiskParser
//
//  Created by Admin on 05.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Film {

    @NSManaged var descriptionFeed: String?
    @NSManaged var linkFeed: String?
    @NSManaged var pubDateFeed: String?
    @NSManaged var titleFeed: String?
    @NSManaged var urlImage: NSData?

}
