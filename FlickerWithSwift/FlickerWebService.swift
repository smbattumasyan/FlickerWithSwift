//
//  FlickerWebService.swift
//  FlickerWithSwift
//
//  Created by Smbat Tumasyan on 4/12/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit

class FlickerWebService: NSObject {


}

extension FlickerWebService: FlickerServiceProtocol  {

    //------------------------------------------------------------------------------------------
    //MARK - Flicker Service Delegate
    //------------------------------------------------------------------------------------------

    func imagesRequest(completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e1dbbc047d0214c272208bc9682cb7f8&tags=City&format=json&nojsoncallback=1"
        let dataTask = session.dataTaskWithURL(NSURL(string: urlString)!, completionHandler: completionHandler)
        dataTask.resume()
    }

    func imageRequest(photoID:NSString, completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=e1dbbc047d0214c272208bc9682cb7f8&photo_id=\(photoID)&format=json&nojsoncallback=1"
        let dataTask = session.dataTaskWithURL(NSURL(string: urlString)!, completionHandler: completionHandler)
        dataTask.resume()
    }

}
