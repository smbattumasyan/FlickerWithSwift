//
//  FlickerViewController.swift
//  FlickerWithSwift
//
//  Created by Smbat Tumasyan on 4/11/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit

class FlickerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var service: FlickerServiceProtocol?
    let photoManager = PhotoManager()

    //------------------------------------------------------------------------------------------
    //MARK - Life Cycle
    //------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        service = FlickerWebService()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //------------------------------------------------------------------------------------------
    //MARK - Private Methods
    //------------------------------------------------------------------------------------------

    func loadPhoto() {
        service?.imagesRequest({ (data:NSData?, response:NSURLResponse?, error:NSError?) in

            do {
                let imagesJson = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                var photos = NSMutableArray(array: imagesJson.valueForKeyPath("photos.photo.id")?.mutableCopy() as! NSArray)
                var savedPhotos = NSMutableArray(array: self.photoManager.fetchedResultsController.fetchedObjects!)

                 print("imageJson:\(savedPhotos)")

                for i in (savedPhotos.count-1).stride(to: 0, by: -1) {
                    let aPhoto = savedPhotos[i] as! Photo
                    if photos.containsObject(aPhoto.photoID!) {
                        savedPhotos.removeObject(aPhoto)
                    }
                }
                self.photoManager.deletePhotos(savedPhotos as NSArray as! [Photo])

                photos = NSMutableArray(array: imagesJson.valueForKeyPath("photos.photo")?.mutableCopy() as! NSArray)
                savedPhotos = NSMutableArray(array: self.photoManager.fetchedResultsController.fetchedObjects!).valueForKey("photoID").mutableCopy() as! NSMutableArray
                for i in (photos.count-1).stride(to: 0, by: -1) {
                    let aPhoto = photos[i]
                    if savedPhotos.containsObject(aPhoto.valueForKey("id")!) {
                        photos.removeObject(aPhoto)
                    }
                }

                self.photoManager.addPhotos(photos as Array)
                self.photoManager.coreDataManager.saveContext()

            } catch {
                print("error serializing JSON: \(error)")
            }
        })
    }

    func loadPhotoURL(indexPath:NSIndexPath) -> NSString {
        let aPhoto = self.photoManager.fetchSelectedPhoto(indexPath) 
        let photoURL = NSString(format: "https://farm\(aPhoto.farmID).staticflickr.com/\(aPhoto.serverID)/\(aPhoto.photoID)_\(aPhoto.secret).jpg")

        return photoURL
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}




//------------------------------------------------------------------------------------------
//MARK - UITableView Data Source
//------------------------------------------------------------------------------------------

extension FlickerViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.greenColor()

        print("loadphoto\(loadPhotoURL(indexPath))")
        return cell
    }
}

//------------------------------------------------------------------------------------------
//MARK - UITableView Delegate
//------------------------------------------------------------------------------------------

extension FlickerViewController : UICollectionViewDelegate {

}
