//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maryna Bereza on 02.03.2021.
//  Copyright © 2021 Bereza Maryna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
   
    var characters = [CharacterModel]()
    let cellIdentifier = "CharacterCell"
    let cellNibName = "CharacterCell"
    let cellHeight: CGFloat = 140.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let episodesArray  = Array(1...20)

        APIServerManager.getCharactes(array: episodesArray) { [weak self](characters) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.characters = characters
            weakSelf.tableView.reloadData()
        }
    }
    
    func getColorForStatus(status: CharacterModel.Status) -> UIColor {
        
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
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharacterCell
        
        
        if !characters.isEmpty {
            
            let character = characters[indexPath.row]
            let color = getColorForStatus(status: character.status)
            
            let model = CharacterCell.ViewModel.init(statusColor: color,
                                                     name: character.name,
                                                     status: character.status.rawValue,
                                                     imageURL: URL(string: character.image) )
            characterCell.updateModel(model)
        }
        return characterCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
