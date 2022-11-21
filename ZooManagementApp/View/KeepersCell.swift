//
//  KeepersCell.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 19.11.2022.
//

import UIKit

class KeepersCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var animalsTableView: UITableView!
    var keeper: ZooKeeper? {
        didSet {
            configureLabels()
            animalsTableView.dataSource = self
            animalsTableView.delegate = self
            animalsTableView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configureLabels() {
        guard let keeper = keeper else { return }
        nameLabel.text = keeper.name
        idLabel.text = "\(keeper.keeperId)"
        ageLabel.text = "\(keeper.age)"
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension KeepersCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keeper?.animals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedAnimal = keeper?.animals?[indexPath.row]
        cell.textLabel?.text = selectedAnimal?.animalBreed
        return cell
    }
    
    
}
