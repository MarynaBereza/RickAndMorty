//
//  Cell.swift
//  RickAndMorty
//
//  Created by Maryna Bereza on 02.03.2021.
//  Copyright © 2021 Bereza Maryna. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    struct ViewModel {
        let statusColor: UIColor
        let name: String
        let status: String
        let imageURL: URL?
    }

    @IBOutlet private weak var episodeImageView: UIImageView!
    @IBOutlet private weak var episodeNameLabel: UILabel!
    @IBOutlet private weak var episodeStatusLabel: UILabel!
    @IBOutlet private weak var episodeStatusImageView: UIImageView!
    
    static var cachedImages = [URL:UIImage]()

    func updateModel(_ model: ViewModel) {
        if let imageURL = model.imageURL {
            setImage(from: imageURL)
        }
        
        episodeNameLabel.text = model.name
        episodeStatusLabel.text = model.status
        episodeStatusImageView.tintColor = model.statusColor
    }
    
    func setImage(from url: URL) {
        
        if let image = CharacterCell.cachedImages[url] {
            self.episodeImageView.image = image
            return
        }
        
        DispatchQueue.global().async {
            
            guard let imageData = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: imageData)
            CharacterCell.cachedImages[url] = image
            
            DispatchQueue.main.async {
                self.episodeImageView.image = image
            }
        }
    }
}

