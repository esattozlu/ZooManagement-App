//
//  AnimalsCell.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 19.11.2022.
//

import UIKit
import AVFoundation

class AnimalsCell: UITableViewCell {

    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalBreedLabel: UILabel!
    @IBOutlet weak var consumptionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var keeperLabel: UILabel!
    var player = AVAudioPlayer()
    var animal: Animal? {
        didSet {
            configureLabels()
        }
    }
    
    func configureLabels() {
        guard let animal = animal else { return }
        guard let keeper = animal.keeper else { return}
        animalImageView.image = animal.image
        animalBreedLabel.text = animal.animalBreed
        consumptionLabel.text = "\(animal.waterConsumption.formattedWithSeparator)"
        countLabel.text = "\(animal.count)"
        keeperLabel.text = "\(keeper.name)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func speakerButtonClicked(_ sender: Any) {
        guard let animal = animal else { return }
        guard let audioPath = Bundle.main.path(forResource: animal.sound, ofType: "mp3") else { return }
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
