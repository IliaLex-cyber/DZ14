//
//  TaskViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 16.11.2022.
//

import UIKit
import RealmSwift
class TaskViewController: UIViewController {

    public var task: TasksList?
    public var deletionHandler: (() -> Void)?
    
    
    @IBOutlet var label: UILabel!
    
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task?.task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTask))
    }
   
    @objc func deleteTask() {
        guard let currentTask = self.task else {
            return
        }
        realm.beginWrite()
        realm.delete(currentTask)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
