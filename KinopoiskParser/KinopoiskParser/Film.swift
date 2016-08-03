//
//  Film.swift
//  KinopoiskParser
//
//  Created by Admin on 02.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import CoreData

class Film: NSManagedObject {
    @NSManaged var titleFeed: String?
    @NSManaged var descriptionFeed: String?
    @NSManaged var pubDateFeed: String?
    @NSManaged var linkFeed: String?
    @NSManaged var urlImage: NSData?

// Insert code here to add functionality to your managed object subclass

}
