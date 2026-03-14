//
//  ConnectUserCell.swift
//  FYEO
//
//  Created by Harvi Jivani on 29/01/26.
//

import UIKit

class ConnectUserCell: UITableViewCell {

    static let identifier = "ConnectUserCell"
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var onFollowTapped: (() -> Void)?
    
    func configure(with user: SuggestedUser){
        userNameLabel.text = user.userName
        displayNameLabel.text = user.displayName
        followButton.setTitle(user.isFollowed ? "Following" : "Follow", for: .normal)
        userImage.loadImage(from: user.imageUrl)
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
    }
    
    @IBAction func followTapped(_ sender: UIButton) {
        onFollowTapped?()
    }
    
}
