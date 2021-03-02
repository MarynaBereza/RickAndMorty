//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maryna Bereza on 02.03.2021.
//  Copyright © 2021 Bereza Maryna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var episodesTableView: UITableView!
   
    var episodes = [EpisodeModel]()
    let cellIdentifier = "EpisodeCell"
    let cellNibName = "Cell"
    let cellHeight: CGFloat = 140.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        episodesTableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let episodesArray  = Array(1...20)

        APIServerManager.episodesRequest(array: episodesArray) { [weak self](episodes) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.episodes = episodes
            weakSelf.episodesTableView.reloadData()
        }
    }
    
    func getColorForStatus(status: EpisodeModel.Status) -> UIColor {
        
        switch status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
        
        
        if !episodes.isEmpty {
            
            let episode = episodes[indexPath.row]
            let color = getColorForStatus(status: episode.status)
            
            let model = Cell.ViewModel.init(statusColor: color,
                                            episodeName: episode.name,
                                            episodeStatus: episode.status.rawValue,
                                            episodeImageURL: URL(string: episode.image) )
            episodeCell.updateModel(model)
        }
        return episodeCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
