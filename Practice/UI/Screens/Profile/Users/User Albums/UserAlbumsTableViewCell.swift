//
//  UserAlbumsTableViewCell.swift
//  Practice
//
//  Created by Cypress on 2/18/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserAlbumsTableViewCell: UITableViewCell {
    static let storyboardId = "UserAlbumsTableViewCell"
    
    // MARK: Outlets
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewConfigure()
        setupViewModel()
        initialNetworkBinding()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = UIColor.white
    }
    
    // MARK: Properties
    
    private var userAlbumPhotos: [UserAlbumPhoto] = []
    private var albumViewModel: UserAlbumsViewModel?
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func collectionViewConfigure() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public func userAlbumConfigure(with model: UserAlbum) {
        albumNameLabel.text = model.title
        collectionView.reloadData()
    }
    
    private func setupViewModel() {
        albumViewModel = UserAlbumsViewModel()
    }
    
    func initialNetworkBinding() {
        let url = "https://jsonplaceholder.typicode.com/photos"
        NetworkService.shared.getDataFromURL(url: url, from: [UserAlbumPhoto].self) {[weak self] (data) in
            do {
                try self?.userAlbumPhotos = data.get()
                self?.collectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension UserAlbumsTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let album = albumViewModel?.userAlbums.value.map { $0.id }
        guard let albumId = album else { return 0 }
        let photoId = userAlbumPhotos.filter { $0.albumId == albumId[section] }.map { $0 }
        print(photoId.count)
        return photoId.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserAlbumsCollectionViewCell.storyboardId, for: indexPath) as? UserAlbumsCollectionViewCell else {return UICollectionViewCell()}
        let album = albumViewModel?.userAlbums.value.map { $0.id }
        guard let albumId = album else {return UICollectionViewCell() }
        let photoId = userAlbumPhotos.filter { $0.albumId == albumId[indexPath.section] }.map { $0 }
        cell.configureAlbumPictures(with: photoId[indexPath.item])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size.height

        return CGSize(width: size - 180, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: -8)
    }
}
