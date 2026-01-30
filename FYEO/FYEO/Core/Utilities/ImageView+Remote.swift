//
//  ImageView+Remote.swift
//  FYEO
//
//  Created by Harvi Jivani on 29/01/26.
//

import UIKit

extension UIImageView {

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            self.image = UIImage(systemName: "person.circle")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
