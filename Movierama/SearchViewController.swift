//
//  SearchViewController.swift
//  Movierama
//
//  Created by Ethan Schmalz on 11/10/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//


import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet var collectionView: UICollectionView!
    
    let store = MovieStore()
    let photoDataSource = PhotoDataSource()
    let searchController = UISearchController(searchResultsController: nil)
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self
        navigationItem.titleView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "search"?:
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
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        searchController.isActive = false
//        self.photoDataSource.photos.removeAll()
//        self.collectionView.reloadData()
//    }
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchController.searchBar.endEditing(true)
        TMDBAPI.query = searchController.searchBar.text!
        print("Searching for movies")
        store.fetchSearchedMovies{
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching movies: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadData()
        }
    }
}

