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
    @NSManaged var descriptionFeed: String?
    @NSManaged var linkFeed: String?
    @NSManaged var pubDateFeed: String?
    @NSManaged var titleFeed: String?
    @NSManaged var urlImage: String?

   
}

