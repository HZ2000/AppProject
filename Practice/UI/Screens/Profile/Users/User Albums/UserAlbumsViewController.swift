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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Properties
    
    private var viewModel: UserAlbumsViewModel?
    private var userAlbumPhotosViewModel: UserAlbumPhotosViewModel?
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViewModel() {
        viewModel = UserAlbumsViewModel()
        userAlbumPhotosViewModel = UserAlbumPhotosViewModel()
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
        guard let userAlbumPhotos = userAlbumPhotosViewModel?.userAlbumPhotos.value , let userAlbum = viewModel?.userAlbums.value , let cell = tableView.dequeueReusableCell(withIdentifier: UserAlbumsTableViewCell.storyboardId, for: indexPath) as? UserAlbumsTableViewCell  else { return UITableViewCell()
        }
        
        let currentUser = userAlbum.filter { $0.userId == UsersListViewController.currentUser}.map {$0}
        
        guard let filteredPhotos = userAlbumPhotosViewModel?.getPhotos(from: userAlbumPhotos, with: indexPath) else { return UITableViewCell() }
        cell.userAlbumConfigure(with: currentUser[indexPath.row],filteredPhotos: filteredPhotos)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
