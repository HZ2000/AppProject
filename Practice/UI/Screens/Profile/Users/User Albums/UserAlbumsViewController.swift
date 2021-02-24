//
//  UserAlbumsViewController.swift
//  Practice
//
//  Created by Cypress on 2/18/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserAlbumsViewController: UIViewController {
    static let storyboardId = "UserAlbumsViewController"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel?.title
        tableViewConfigure()
        setupViewModel()
        //setupViewModelBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: Properties
    
    private var viewModel: UserAlbumsViewModel?
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func tableViewConfigure() {
        //tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViewModel() {
        viewModel = UserAlbumsViewModel()
    }
    
    private func setupViewModelBinding() {
        guard let modelUsers = viewModel?.userAlbums else {return}
        modelUsers
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "UserAlbumsTableViewCell", cellType: UserAlbumsTableViewCell.self)) { (row,item,cell) in
            cell.userAlbumConfigure(with: item)
        }.disposed(by: bag)
    }
}

// MARK: UITableViewDelegate

extension UserAlbumsViewController: UITableViewDelegate , UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let userAlbum = viewModel?.userAlbums.value else {return 0}
        let currentUser = userAlbum.filter { $0.userId == UsersListViewController.currentUser}.map {$0}
        return currentUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userAlbum = viewModel?.userAlbums.value , let cell = tableView.dequeueReusableCell(withIdentifier: UserAlbumsTableViewCell.storyboardId, for: indexPath) as? UserAlbumsTableViewCell  else { return UITableViewCell() }
        let currentUser = userAlbum.filter { $0.userId == UsersListViewController.currentUser}.map {$0}
        cell.userAlbumConfigure(with: currentUser[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
