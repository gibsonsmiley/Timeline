//
//  ImageController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func uploadImage(image: UIImage, completion: (identifier: String?) -> Void) {
        completion(identifier: "K1l4125TYvKMc7rcp5e")
    }
    
    static func imageForIdentifier(indentifier: String, completion: (UIImage?) -> Void) {
        completion(UIImage(named: "MockPhoto"))
    }
    
    
}