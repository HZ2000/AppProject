//
//  UserAlbumsViewController.swift
//  Practice
//
//  Created by Cypress on 2/18/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class UserAlbumsViewController: UIViewController {
    static let storyboardId = "UserAlbumsViewController"
    
    // MARK: Outlets
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewConfigure()
    }
    
    // MARK: Properties
    
    var userAlbums = [UserAlbums]()
    
    // MARK: Helpers
    
    private func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func urlJsonParsing() {
        let urlString = "https://jsonplaceholder.typicode.com/albums"
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
                    self?.userAlbums = try decoder.decode([UserAlbums].self, from: dataResponse)
                    self?.tableView.reloadData()
                } catch {
                    print("Couldn't do the parsing")
                }
            }
        }
        task.resume()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension UserAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserAlbumsTableViewCell.storyboardId, for: indexPath) as? UserAlbumsTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
