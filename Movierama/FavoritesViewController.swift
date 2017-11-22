//
//  FavoritesViewController.swift
//  Movierama
//
//  Created by Ethan Schmalz on 11/12/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    
    let store = MovieStore.sharedMovieStore
    static var favoriteMovies = [Movie]()
    let photoDataSource = PhotoDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        print("Successfully found \(FavoritesViewController.favoriteMovies.count) photos.")
        self.photoDataSource.photos = FavoritesViewController.favoriteMovies
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        print("Successfully found \(FavoritesViewController.favoriteMovies.count) photos.")
        self.photoDataSource.photos = FavoritesViewController.favoriteMovies

        self.collectionView.reloadData()
        
    }
    
    @IBAction func saveChanges (_ segue: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "favorites"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.movie = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        store.fetchImage(for: photo) { (result) -> Void in
            
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
    
    static func remove(movie: Movie){
        for favorite in favoriteMovies{
            if movie.movieID == favorite.movieID{
                if let index = favoriteMovies.index(of: favorite) {
                    favoriteMovies.remove(at: index)
                }
            }
        }
    }
    
}


