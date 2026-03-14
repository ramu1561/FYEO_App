//
//  FeedFilterCollectionViewCell.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/02/26.
//

import UIKit

final class FeedFilterCollectionViewCell: UICollectionViewCell {

    static let identifier = "FeedFilterCollectionViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with title: String) {
        titleLabel.text = title
        updateUI()
    }

    private func updateUI() {
        if isSelected {
            contentView.backgroundColor = .black
            titleLabel.textColor = .white
        } else {
            contentView.backgroundColor = .systemGray5
            titleLabel.textColor = .black
        }
    }
}
struct FilterItem {
    let title: String
}
