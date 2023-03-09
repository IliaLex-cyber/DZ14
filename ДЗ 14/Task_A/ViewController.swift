//
//  ViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBAction func saveButton(_ sender: Any) {
        Persistance.shared.userName = name.text
        Persistance.shared.userSurname = surname.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = Persistance.shared.userName
        surname.text = Persistance.shared.userSurname
    }
}

