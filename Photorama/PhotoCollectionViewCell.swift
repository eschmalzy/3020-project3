//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Ethan Schmalz on 11/3/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            photoView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            photoView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
}
