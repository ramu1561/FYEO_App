//
//  ChatCell.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/02/26.
//

import UIKit

final class ChatCell: UITableViewCell {

    static let identifier = "ChatCell"

    private let bubbleView = UIView()
    private let messageLabel = UILabel()

    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 16)

        bubbleView.layer.cornerRadius = 18
        bubbleView.addSubview(messageLabel)

        contentView.addSubview(bubbleView)

        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.75),

            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 14),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -14)
        ])
    }

    func configure(message: ChatMessage) {
        messageLabel.text = message.text

        if message.sender == .sender {
            leadingConstraint.isActive = false
            trailingConstraint.isActive = true
            bubbleView.backgroundColor = .black
            messageLabel.textColor = .white
        } else {
            trailingConstraint.isActive = false
            leadingConstraint.isActive = true
            bubbleView.backgroundColor = UIColor.systemGray6
            messageLabel.textColor = .black
        }
    }
}
enum MessageSender {
    case sender
    case receiver
}
struct ChatMessage {
    let text: String
    let sender: MessageSender
}
