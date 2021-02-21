//
//  UsersListViewController.swift
//  Practice
//
//  Created by Cypress on 2/17/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UsersListViewController: UIViewController {
    static let storyboardId = "UsersListViewController"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfigure()
        setupViewModel()
        setupViewModelBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.deselectSelectedRow(animated: true)
    }
    
    // MARK: Properties
    
    private var viewModel: UsersListViewModel?
    let bag = DisposeBag()
    private lazy var userAlbumsViewController = UIViewController.getViewController(id: UserAlbumsViewController.storyboardId) as? UserAlbumsViewController
    static var currentUser: Int = 0
    
    // MARK:  Helpers
    
    private func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViewModel() {
        viewModel = UsersListViewModel()
    }
    
    private func setupViewModelBinding() {
        viewModel?.fetchUsersViewModel().bind(to: tableView.rx.items(cellIdentifier: UsersTableViewCell.storyboardId)) { index,viewModel,cell in
            
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension UsersListViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel?.fetchUsers().count ?? 0
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.storyboardId, for: indexPath) as? UsersTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userAlbumsVC = userAlbumsViewController else {return}
        UsersListViewController.currentUser = indexPath.row + 1
        print("The current user is : \(UsersListViewController.currentUser)")
        navigationController?.pushViewController(userAlbumsVC, animated: true)
    }
}
