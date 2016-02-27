//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/26/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithImageIdentifier(identifier: String) {
        ImageController.imageForIdentifier(identifier, completion: { (image) -> Void in
            self.imageView.image = image
        })
    }
}
