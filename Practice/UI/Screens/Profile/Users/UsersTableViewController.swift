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
        userAddUsers()
    }
    
    // MARK: Properties
    var users: Array = [Users]()
    
    // MARK:  Helpers
    
    private func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func urlJsonParsing() {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                //print(jsonResponse)
                for result in jsonResponse as! [[String:Any]] {
                    guard let id = result["id"] as? Int,
                        let name = result["name"] as? String,
                        let username = result["username"] as? String,
                        let email = result["email"] as? String,
                        let phone = result["phone"] as? String else {return}
                    
                    let user = Users(id: id, name: name, username: username, email: email, phone: phone)
                    self.users.append(user)
                }
            } catch let parsingError {
                print("Error", parsingError)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UsersTableViewCell else {return UITableViewCell()}
        cell.userCellConfigure(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
