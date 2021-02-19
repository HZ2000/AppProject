//
//  UserAlbumsTableViewCell.swift
//  Practice
//
//  Created by Cypress on 2/18/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class UserAlbumsTableViewCell: UITableViewCell {
    static let storyboardId = "UserAlbumsTableViewCell"
    
    // MARK: Outlets
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewConfigure()
        urlJsonParsing()
    }
    
    // MARK: Properties
    
    private var userAlbumPhotos = [UserAlbumPhotos]()
    
    // MARK: Helpers
    
    public func userAlbumConfigure(with model: UserAlbums) {
        albumNameLabel.text = model.title
    }
    
    private func collectionViewConfigure() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
     
    // FIX - Create NETWWORK LAYER
    
    private func urlJsonParsing() {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        let task = session.dataTask(with: url) {[weak self] (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            DispatchQueue.main.async {
                do {
                    self?.userAlbumPhotos = try decoder.decode([UserAlbumPhotos].self, from: dataResponse)
                } catch {
                    print("Couldn't do the parsing")
                }
            }
        }
        
        task.resume()
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension UserAlbumsTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let currentUserAlbumPhoto = userAlbumPhotos.filter { $0.albumId == UsersListViewController.currentUser }.map {$0}
        print("Current Photos : \(currentUserAlbumPhoto.count)")
        return currentUserAlbumPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserAlbumsCollectionViewCell.storyboardId, for: indexPath) as? UserAlbumsCollectionViewCell else {return UICollectionViewCell()}
        let currentUserAlbumPhoto = userAlbumPhotos.filter { $0.albumId == UsersListViewController.currentUser }.map {$0}
        cell.configureAlbumPictures(with: currentUserAlbumPhoto[indexPath.row])
        return cell
    }
}
