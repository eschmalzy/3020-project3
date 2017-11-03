//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Ethan Schmalz on 11/3/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var photoView: UIImageView!
    
    var photo: Photo! {
        didSet{
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.photoView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
}
