//
//  ChatViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/02/26.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    
    private var messages: [ChatMessage] = [
        ChatMessage(text: "I hope you’re enjoying your day as much as I do", sender: .receiver),
        ChatMessage(text: "Everything is amazing", sender: .receiver),
        ChatMessage(text: "Weather is nice", sender: .receiver)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let text = inputTextField.text, !text.isEmpty else { return }
        
        let randomSender: MessageSender = Bool.random() ? .sender : .receiver
        let message = ChatMessage(text: text, sender: randomSender)
        
        messages.append(message)
        inputTextField.text = ""
        
        tableView.reloadData()
        scrollToBottom()
    }
    private func scrollToBottom() {
        let index = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: index, at: .bottom, animated: true)
    }
}
extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatCell.identifier,
            for: indexPath
        ) as! ChatCell

        cell.configure(message: messages[indexPath.row])
        return cell
    }
}
