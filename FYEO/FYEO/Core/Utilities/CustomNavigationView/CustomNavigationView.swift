//
//  CustomNavigationView.swift
//  FYEO
//
//  Created by Harvi Jivani on 13/03/26.
//


import UIKit

class CustomNavigationView: UIView {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rightStackView: UIStackView!
    //@IBOutlet weak var searchBar: UISearchBar!

    var backAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        //searchBar.isHidden = true
        subtitleLabel.isHidden = true
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .label
        
        
    }

    @IBAction func backTapped(_ sender: UIButton) {
        backAction?()
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }

    func setSubtitle(_ subtitle: String) {
        subtitleLabel.isHidden = false
        subtitleLabel.text = subtitle
    }

    func showSearchBar() {
        //searchBar.isHidden = false
        titleLabel.isHidden = true
        subtitleLabel.isHidden = true
    }

    func hideBackButton(_ hide: Bool) {
        backButton.isHidden = hide
    }

    func addRightButton(
        image: UIImage?,
        action: @escaping () -> Void
    ) {

        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)

        button.addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)

        rightStackView.addArrangedSubview(button)
    }
}
