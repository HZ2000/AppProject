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
    
    public func userAlbumConfigure(with model: UserAlbum , filteredPhotos: [UserAlbumPhoto]) {
        albumNameLabel.text = model.title
        userAlbumPhotos = filteredPhotos
        collectionView.reloadData()
    }
    
    private func setupViewModel() {
        albumViewModel = UserAlbumsViewModel()
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension UserAlbumsTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("The photos count is: \(userAlbumPhotos.count)")
        return userAlbumPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserAlbumsCollectionViewCell.storyboardId, for: indexPath) as? UserAlbumsCollectionViewCell
            else { return UICollectionViewCell() }
        cell.configureAlbumPictures(with: userAlbumPhotos[indexPath.row])
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
