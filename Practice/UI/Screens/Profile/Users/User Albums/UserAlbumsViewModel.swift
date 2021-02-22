//
//  UserAlbumsViewModel.swift
//  Practice
//
//  Created by Cypress on 2/22/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserAlbumsViewModel {
    let title = "Albums"
    
    var userAlbums: BehaviorRelay<[UserAlbum]> = BehaviorRelay(value: [])
    let bag = DisposeBag()
    
    init() {
        getUserData()
    }

    func getUserData() {
        let urlString = "https://jsonplaceholder.typicode.com/albums"
             guard let url = URL(string: urlString) else {return}
             
             let session = URLSession.shared
             let decoder = JSONDecoder()
             
             let task = session.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        return
                }
                
                do {
                    let users = try decoder.decode([UserAlbum].self, from: dataResponse)
                    return self.userAlbums.accept(users)
                } catch {
                    print(NSError(domain: "Couldn't parse the JSon", code: 3, userInfo: nil))
                }
        }
        task.resume()
    }
}
