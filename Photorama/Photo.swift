//
//  Photo.swift
//  Photorama
//
//  Created by Ethan Schmalz on 10/27/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//

import Foundation

class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date

    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date){
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
    
    
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}
