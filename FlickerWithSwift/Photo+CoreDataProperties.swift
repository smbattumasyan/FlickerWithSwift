//
//  Photo+CoreDataProperties.swift
//  FlickerWithSwift
//
//  Created by Smbat Tumasyan on 4/12/16.
//  Copyright © 2016 EGS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Photo {

    @NSManaged var farmID: String?
    @NSManaged var photoDate: NSDate?
    @NSManaged var photoDescription: String?
    @NSManaged var photoID: String?
    @NSManaged var photoName: String?
    @NSManaged var secret: String?
    @NSManaged var serverID: String?

}
