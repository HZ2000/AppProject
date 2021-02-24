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
    
    // MARK: Properties
    
    private var viewModel: UserAlbumsViewModel?
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func tableViewConfigure() {
        //tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    private func setupViewModel() {
        viewModel = UserAlbumsViewModel()
        tableView.reloadData()
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

extension UserAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel?.userAlbums.value.count)
        return viewModel?.userAlbums.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let albumViewModel = viewModel?.userAlbums ,let cell = tableView.dequeueReusableCell(withIdentifier: UserAlbumsTableViewCell.storyboardId, for: indexPath) as? UserAlbumsTableViewCell else {return UITableViewCell()}
        cell.userAlbumConfigure(with: albumViewModel.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
