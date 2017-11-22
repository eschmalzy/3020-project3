//
//  Photo.swift
//  Photorama
//
//  Created by Ethan Schmalz on 10/27/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//

import Foundation

class Movie: NSObject, NSCoding {
    let title: String
    let posterPath: String
    let remoteURL: URL
    let movieID: Int
    let dateReleased: Date
    let movieDescription: String

    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(posterPath, forKey: "posterPath")
        aCoder.encode(remoteURL, forKey: "remoteURL")
        aCoder.encode(movieID, forKey: "movieID")
        aCoder.encode(dateReleased, forKey: "dateReleased")
        aCoder.encode(movieDescription, forKey: "movieDescription")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        posterPath = aDecoder.decodeObject(forKey: "posterPath") as! String
        remoteURL = aDecoder.decodeObject(forKey: "remoteURL") as! URL
        movieID = aDecoder.decodeInteger(forKey: "movieID")
        dateReleased = aDecoder.decodeObject(forKey: "dateReleased") as! Date
        movieDescription = aDecoder.decodeObject(forKey: "movieDescription") as! String
        
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.movieID == rhs.movieID
    }
    
    init(title: String, posterPath: String, movieID: Int, remoteURL: URL, dateReleased: Date, movieDescription: String){
        self.title = title
        self.posterPath = posterPath
        self.movieID = movieID
        self.remoteURL = remoteURL
        self.dateReleased = dateReleased
        self.movieDescription = movieDescription
        super.init()
    }
    
    
}

