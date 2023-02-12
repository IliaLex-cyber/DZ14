//
//  Task_B_ViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 15.11.2022.
//

import UIKit
import RealmSwift

class TasksList: Object {
    @objc dynamic var task = ""
    //@objc dynamic var completed = false
}

class Task_B_ViewController: UIViewController {
    
    let realm = try! Realm()
    var tasks = [TasksList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Realm To do list"
        tasks = realm.objects(TasksList.self).map({ $0 })
        taskBTableView.delegate = self
        taskBTableView.dataSource = self
        taskBTableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskBCell")
    }
    
    @IBOutlet weak var taskBTableView: UITableView!
    
    func updateTasks() {
        taskBTableView.reloadData()
    }
    
    @IBAction func didTapAddnewTask() {
        guard let vc = storyboard?.instantiateViewController(identifier: "entry") as? EntryViewController else { return }
        vc.completionHandler = { [weak self] in self?.refresh()}
        vc.title = "New task"

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh() {
        tasks = realm.objects(TasksList.self).map({ $0 })
        taskBTableView.reloadData()
    }
    
    
}

extension Task_B_ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = tasks[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "task") as? TaskViewController else {
            return
        }
        
        vc.task = task
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.title = task.task
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension Task_B_ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskBCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.task
        
        return cell
    }
    
    
}
