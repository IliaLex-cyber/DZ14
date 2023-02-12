//
//  EntryViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 16.11.2022.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate{

    let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.becomeFirstResponder()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        
        return true
    }
    
    
    @objc func saveTask() {
        if let text = field.text, !text.isEmpty {
            realm.beginWrite()
            let newTask = TasksList()
            newTask.task = text
            realm.add(newTask)
            
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            print("add something")
        }
    }
    
    
  

}
