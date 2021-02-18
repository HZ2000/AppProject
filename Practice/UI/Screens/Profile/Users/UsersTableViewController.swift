//
//  UsersTableViewController.swift
//  Practice
//
//  Created by Cypress on 2/17/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class UsersTableViewController: UIViewController {
    static let storyboardId = "UsersTableViewController"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlJsonParsing()
        tableViewConfigure()
    }
    
    // MARK: Properties
    
    var users = [Users]()
    lazy var userAlbumsViewController = UIViewController.getViewController(id: UserAlbumsViewController.storyboardId) as? UserAlbumsViewController
    // MARK:  Helpers
    
    private func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func urlJsonParsing() {
        let urlString = "https://jsonplaceholder.typicode.com/users"
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
                    self?.users = try decoder.decode([Users].self, from: dataResponse)
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

extension UsersTableViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.storyboardId, for: indexPath) as? UsersTableViewCell else {return UITableViewCell()}
        cell.userCellConfigure(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userAlbumsVC = userAlbumsViewController else {return}
        navigationController?.pushViewController(userAlbumsVC, animated: true)
    }
}
