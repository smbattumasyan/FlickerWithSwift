//
//  TagManager.swift
//  FlickerWithSwift
//
//  Created by Smbat Tumasyan on 4/12/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import CoreData

class TagManager: NSObject {

    let coreDataManager = CoreDataManager()

    //------------------------------------------------------------------------------------------
    //MARK - Public Methods
    //------------------------------------------------------------------------------------------


    func addTags(jsonDict: [NSString]) {
        for tagName in jsonDict {
            let tagEntity       = NSEntityDescription.entityForName("Photo", inManagedObjectContext: self.fetchedResultsController.managedObjectContext)
            let tagRecord       = Tag(entity: tagEntity!, insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext)
            tagRecord.tag = tagName as String
        }
    }

    func deleteTags(tags:[Tag]) {
        for aTag in tags {
            self.coreDataManager.managedObjectContext.deleteObject(aTag)
        }
    }

    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest             = NSFetchRequest(entityName: "Tag")

        fetchRequest.fetchBatchSize  = 20
        // Add Sort Descriptors
        let sortDescriptor           = NSSortDescriptor(key: "tag", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try fetchedResultsController.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }

        return fetchedResultsController
    }()
}
