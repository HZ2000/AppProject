//
//  NetworkService.swift
//  Practice
//
//  Created by Cypress on 2/21/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class NetworkService: NetworkSericeProtocol {
    // MARK: Helpers
    
    func fetchUsers() -> Observable<[User]> {
        return Observable.create { (observer) -> Disposable in
            let urlString = "https://jsonplaceholder.typicode.com/users"
            guard let url = URL(string: urlString) else {return observer.onError(NSError(domain: "Couldn't find the URL", code: 1, userInfo: nil)) as! Disposable}
            
            let session = URLSession.shared
            let decoder = JSONDecoder()
            
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                      error == nil else {
                    observer.onError(NSError(domain: "Couldn't fetch the data", code: 2, userInfo: nil))
                    return
                }
                
                do {
                    let users = try decoder.decode([User].self, from: dataResponse)
                    observer.onNext(users)
                } catch {
                    observer.onError(NSError(domain: "Couldn't parse the JSon", code: 3, userInfo: nil))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchAlbums() -> Observable<[UserAlbum]> {
        return Observable.create { (observer) -> Disposable in
            let urlString = "https://jsonplaceholder.typicode.com/albums"
            guard let url = URL(string: urlString) else {return observer.onError(NSError(domain: "Couldn't find the URL", code: 1, userInfo: nil)) as! Disposable}
            
            let session = URLSession.shared
            let decoder = JSONDecoder()
            
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                      error == nil else {
                    observer.onError(NSError(domain: "Couldn't fetch the data", code: 2, userInfo: nil))
                    return
                }
                
                do {
                    let userAlbums = try decoder.decode([UserAlbum].self, from: dataResponse)
                    observer.onNext(userAlbums)
                } catch {
                    observer.onError(NSError(domain: "Couldn't parse the JSon", code: 3, userInfo: nil))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchUserAlbumPhotos() -> Observable<[UserAlbumPhoto]> {
        return Observable.create { (observer) -> Disposable in
            let urlString = "https://jsonplaceholder.typicode.com/photos"
            guard let url = URL(string: urlString) else {return observer.onError(NSError(domain: "Couldn't find the URL", code: 1, userInfo: nil)) as! Disposable}
            
            let session = URLSession.shared
            let decoder = JSONDecoder()
            
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                      error == nil else {
                    observer.onError(NSError(domain: "Couldn't fetch the data", code: 2, userInfo: nil))
                    return
                }
                
                do {
                    let userAlbumPhotos = try decoder.decode([UserAlbumPhoto].self, from: dataResponse)
                    observer.onNext(userAlbumPhotos)
                } catch {
                    observer.onError(NSError(domain: "Couldn't parse the JSon", code: 3, userInfo: nil))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
