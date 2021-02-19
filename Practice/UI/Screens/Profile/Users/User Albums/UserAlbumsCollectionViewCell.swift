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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: Helpers
    
    public func configureAlbumPictures(with model: UserAlbumPhotos) {
        guard let photoUrl = URL(string: model.url),
            let placeholderUrl = URL(string: model.thumbnailUrl) else {return}
        do {
            let data = try Data(contentsOf: placeholderUrl)
            userPhotosImageView.sd_setImage(with: photoUrl , placeholderImage: UIImage(data: data))
        }catch {
            print("Couldn't load the url image")
        }
    }
}
