//
//  UserAlbumsCollectionViewCell.swift
//  Practice
//
//  Created by Cypress on 2/19/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import SDWebImage

class UserAlbumsCollectionViewCell: UICollectionViewCell {
    static let storyboardId = "UserAlbumsCollectionViewCell"

    // MARK: Outlets
    
    @IBOutlet weak var userPhotosImageView: UIImageView!
    
    // MARK: View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.userPhotosImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
    }
    
    // MARK: Helpers
    
    public func configureAlbumPictures(with model: UserAlbumPhoto) {
        guard let photoUrl = URL(string: model.url) else {return}
        userPhotosImageView.sd_setImage(with: photoUrl , placeholderImage: UIImage(named: "placeholder"))        
    }
}
