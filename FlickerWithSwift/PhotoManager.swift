//
//  PhotoManager.swift
//  FlickerWithSwift
//
//  Created by Smbat Tumasyan on 4/12/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import CoreData

class PhotoManager: NSObject {

    let coreDataManager = CoreDataManager()
//    let fetchedResultsController = NSFetchedResultsController()


    //------------------------------------------------------------------------------------------
    //MARK - Public Methods
    //------------------------------------------------------------------------------------------

    func addPhotos(photos:[AnyObject]) {
        print("photos:\(photos)")
        for photo in photos {
            print("photo:\(photo)")
            let photoEntity      = NSEntityDescription.entityForName("Photo", inManagedObjectContext: self.fetchedResultsController.managedObjectContext)
            let photoRecord      = Photo(entity: photoEntity!, insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext)
            let photoDescription = photo.valueForKey("description")
//            let dates = photo.valueForKey("dates")

            photoRecord.farmID           = photo.valueForKey("farm") as? String
            photoRecord.serverID         = photo.valueForKey("server") as? String
            photoRecord.photoID          = photo.valueForKey("id") as? String
            photoRecord.secret           = photo.valueForKey("secret") as? String
            photoRecord.photoName        = photo.valueForKey("title") as? String
//            photoRecord.photoDate        = self.setPhotoDateFormat(dates?.valueForKey("taken") as! String)
            photoRecord.photoDescription = photoDescription?.valueForKey("_content") as? String
        }
    }

    func deletePhotos(photos:[Photo]) {
        for aPhoto in photos {
            self.coreDataManager.managedObjectContext.deleteObject(aPhoto)
        }
    }

    func fetchSelectedPhoto(indexPath:NSIndexPath) -> Photo {
        return self.fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
    }

    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest             = NSFetchRequest(entityName: "Photo")

        fetchRequest.fetchBatchSize  = 20
        // Add Sort Descriptors
        let sortDescriptor           = NSSortDescriptor(key: "photoDate", ascending: true)
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

    //------------------------------------------------------------------------------------------
    //MARK - Private Methods
    //------------------------------------------------------------------------------------------

    func setPhotoDateFormat(dateString: NSString) -> NSDate {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let photoDate  = dateFormat.dateFromString(dateString as String)
        return photoDate!
    }
}
