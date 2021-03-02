//
//  Cell.swift
//  RickAndMorty
//
//  Created by Maryna Bereza on 02.03.2021.
//  Copyright © 2021 Bereza Maryna. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    struct ViewModel {
        let statusColor: UIColor
        let episodeName: String
        let episodeStatus: String
        let episodeImageURL: URL?
    }

    @IBOutlet private weak var episodeImageView: UIImageView!
    @IBOutlet private weak var episodeNameLabel: UILabel!
    @IBOutlet private weak var episodeStatusLabel: UILabel!
    @IBOutlet private weak var episodeStatusImageView: UIImageView!
    
    static var cachedImages = [URL:UIImage]()

    func updateModel(_ model: ViewModel) {
        if let imageURL = model.episodeImageURL {
            setImage(from: imageURL)
        }
        
        episodeNameLabel.text = model.episodeName
        episodeStatusLabel.text = model.episodeStatus
        episodeStatusImageView.tintColor = model.statusColor
    }
    
    func setImage(from url: URL) {
        
        if let image = Cell.cachedImages[url] {
            self.episodeImageView.image = image
            return
        }
        
        DispatchQueue.global().async {
            
            guard let imageData = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: imageData)
            Cell.cachedImages[url] = image
            
            DispatchQueue.main.async {
                self.episodeImageView.image = image
            }
        }
    }

    override func prepareForReuse() {
        episodeImageView.image = UIImage(systemName: "sun.min")
    }
}

