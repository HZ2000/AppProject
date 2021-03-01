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
        
        navigationItem.title = viewModel?.title
        setupViewModel()
        tableViewConfigure()
        setupViewModelBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.deselectSelectedRow(animated: true)
    }
    
    // MARK: Properties
    
    private var viewModel: UsersListViewModel?
    private let bag = DisposeBag()
    private lazy var userAlbumsViewController = UIViewController.getViewController(id: UserAlbumsViewController.storyboardId) as? UserAlbumsViewController
    static var currentUser: Int = 0
    
    // MARK:  Helpers
    
    private func tableViewConfigure() {
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func setupViewModel() {
        viewModel = UsersListViewModel()
    }
    
    private func setupViewModelBinding() {
        guard let modelUsers = viewModel?.users else {return}
        modelUsers
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "UsersTableViewCell", cellType: UsersTableViewCell.self)) { (row,item,cell) in
            cell.userCellConfigure(with: item)
        }.disposed(by: bag)
    }
    
    
}

// MARK: UITableViewDelegate

extension UsersListViewController: UITableViewDelegate   {
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
