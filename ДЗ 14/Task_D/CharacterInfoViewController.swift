//
//  CharacterInfoViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 02.02.2023.
//

import UIKit

class CharacterInfoViewController: UIViewController {
    
    @IBOutlet weak var charNameLabel: UILabel!
    @IBOutlet weak var charStatusLabel: UILabel!
    @IBOutlet weak var charGenderLabel: UILabel!
    @IBOutlet weak var charLastLocationLabel: UILabel!
    @IBOutlet weak var charImage: UIImageView!
    
    @IBOutlet weak var firstSeenLabel: UILabel!
    
    @IBOutlet weak var episodesLabel: UILabel!
    
    
    var characterName: String?
    var status: String?
    var gender: String?
    var location: String?
    var characterImage: String?
    var charFirstSeen: String?
    var allEpisodes: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charNameLabel.text = characterName
        charStatusLabel.text = status
        charGenderLabel.text = gender
        charLastLocationLabel.text = location
        firstSeenLabel.text = charFirstSeen
        episodesLabel.text = allEpisodes?.joined(separator: " ")
        guard let charImageURL = URL (string: characterImage ?? "") else { return }
        charImage.af.setImage(withURL: charImageURL)
        
    }
}
