//
//  EditViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 15.12.2022.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    static let identifier = "EditViewController"
    
    var task: CD_Task!
    weak var delegate: TasksDelegate?
    
    @IBOutlet weak var editTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextView.text = task?.text

    }
    override func viewDidAppear(_ animated: Bool) {
        editTextView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func updateTask() {
        
        CoreDataManager.shared.save()
        delegate?.refreshTasks()
    }
    
    private func deleteTask() {
        
        delegate?.deleteTask(with: task.id!)
        CoreDataManager.shared.deleteTaskCDM(task)
    }
}


extension EditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        task?.text = editTextView.text
        if task?.text?.isEmpty ?? true {
            deleteTask()
        } else {
            updateTask()
        }
    }
}
