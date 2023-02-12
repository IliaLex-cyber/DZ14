//
//  Task_D_ViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 17.01.2023.
//

import UIKit
import AlamofireImage

class Task_D_ViewController: UIViewController {

    @IBOutlet weak var task_D_tableView: UITableView!
   
    var characters: [CharacterModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharactersLoader().loadCharacters { characters in
            self.characters = characters.results
            self.task_D_tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowCharacterInfo" else {return}
        let idexPath = task_D_tableView.indexPathForSelectedRow
        let vc = segue.destination as? CharacterInfoViewController
        vc?.characterName = characters[idexPath?.row ?? 0].name
        vc?.location = characters[idexPath?.row ?? 0].location.name
        vc?.gender = characters[idexPath?.row ?? 0].gender
        vc?.status = characters[idexPath?.row ?? 0].status
        vc?.charFirstSeen = characters[idexPath?.row ?? 0].episode[0]
        vc?.characterImage = characters[idexPath?.row ?? 0].image
    }
   
}

extension Task_D_ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = task_D_tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! TableViewCell
        let char = characters[indexPath.row]
        cell.nameLabel.text = char.name
        cell.statusLabel.text = char.status
        cell.speciesLabel.text = char.species
        cell.locationLabel.text = char.location.name
        let imageURL = URL(string: char.image)
        cell.preiewImageView.af.setImage(withURL: imageURL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowCharacterInfo", sender: indexPath)
        
    }
    
}

