//
//  ConnectViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 29/01/26.
//

import UIKit

class ConnectViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    private let viewModel = ConnectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.fetchSuggestedUsers()
    }

    func setupTableView(){
        tblView.delegate = self
        tblView.dataSource = self
        let nib = UINib(nibName: ConnectUserCell.identifier, bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: ConnectUserCell.identifier)
    }
    
    func bindViewModel(){
        viewModel.onUsersUpdated = { [weak self] in
            self?.tblView.reloadData()
        }
    }
    
    @IBAction func followAllTapped(_ sender: Any) {
        viewModel.followAll()
    }
}

//MARK: - Tableview delegate and datasource methods
extension ConnectViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConnectUserCell.identifier, for: indexPath) as! ConnectUserCell
        let user = viewModel.user(at: indexPath.row)
        cell.configure(with: user)
        
        cell.onFollowTapped = { [weak self] in
            self?.viewModel.followUser(at: indexPath.row)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
