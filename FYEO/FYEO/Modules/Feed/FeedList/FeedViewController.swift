//
//  FeedViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 04/02/26.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedFilterCollectionView: UICollectionView!
    @IBOutlet weak var feedTableView: UITableView!
    
    private var items: [FilterItem] = [
            .init(title: "All"),
            .init(title: "Unread 3"),
            .init(title: "Favorites 2"),
            .init(title: "Group"),
            .init(title: "Group"),
            .init(title: "Group"),
            .init(title: "Group"),
            .init(title: "Group"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    func setupTableView(){
        feedTableView.delegate = self
        feedTableView.dataSource = self
        let nib = UINib(nibName: FeedListTableViewCell.identifier, bundle: nil)
        feedTableView.register(nib, forCellReuseIdentifier: FeedListTableViewCell.identifier)
    }
    private func setupCollectionView() {
        feedFilterCollectionView.backgroundColor = .clear
        feedFilterCollectionView.showsHorizontalScrollIndicator = false
        
        feedFilterCollectionView.dataSource = self
        feedFilterCollectionView.delegate = self
        feedFilterCollectionView.register(FeedFilterCollectionViewCell.self,
                                          forCellWithReuseIdentifier: FeedFilterCollectionViewCell.identifier)
        
        
        // Default selection
        DispatchQueue.main.async {
            self.feedFilterCollectionView.selectItem(
                at: IndexPath(item: 0, section: 0),
                animated: false,
                scrollPosition: []
            )
        }
    }
}

//MARK: - Tableview delegate and datasource methods
extension FeedViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedListTableViewCell.identifier, for: indexPath) as! FeedListTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedFilterCollectionViewCell.identifier,
            for: indexPath
        ) as! FeedFilterCollectionViewCell

        cell.configure(with: items[indexPath.item].title)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(items[indexPath.item].title)")
    }
}
