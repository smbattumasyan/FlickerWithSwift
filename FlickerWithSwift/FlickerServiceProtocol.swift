//
//  FlickerServiceProtocol.swift
//  FlickerWithSwift
//
//  Created by Smbat Tumasyan on 4/12/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import Foundation

protocol FlickerServiceProtocol: class {
    func imagesRequest(completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void)
    func imageRequest(photoID:NSString, completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void)
}
