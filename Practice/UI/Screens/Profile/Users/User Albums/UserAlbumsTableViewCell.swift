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
        setupViewModelBinding()
    }
    
    // MARK: Properties
    
    private var viewModel: UserAlbumPhotosListViewModel?
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func collectionViewConfigure() {
        collectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    public func userAlbumConfigure(with model: UserAlbum) {
        albumNameLabel.text = model.title
    }
    
    private func setupViewModel() {
        viewModel = UserAlbumPhotosListViewModel()
    }
    
    private func setupViewModelBinding() {
        guard let modelUserPhotos = viewModel?.userAlbumPhotos else {return}
        modelUserPhotos
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "UserAlbumsCollectionViewCell", cellType: UserAlbumsCollectionViewCell.self)) { (row,item,cell) in
            cell.configureAlbumPictures(with: item)
        }.disposed(by: bag)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension UserAlbumsTableViewCell: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
  
}
