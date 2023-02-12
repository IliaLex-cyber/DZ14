//
//  Task_C_ViewController.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 03.12.2022.
//

import UIKit
import CoreData

protocol TasksDelegate: AnyObject {
    func refreshTasks()
    func deleteTask(with id: UUID)
}

class Task_C_ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        taskCTableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        configureSearchBar()
        fetchTasksFromStrage()
    }
    
    @IBOutlet weak var taskCTableView: UITableView!
    @IBOutlet weak var tasksCount: UILabel!
    
    private let searchController = UISearchController()
    
    private var allTasks: [CD_Task] = []{
        didSet {
            tasksCount.text = "\(allTasks.count)\(allTasks.count == 1 ? "Task" : "Tasks")"
            filteredTasks = allTasks
        }
    }
    
    private var filteredTasks: [CD_Task] = []
    
    @IBAction func didTapAddnewCTask() {
        showEdit(createNewTask())
    }
    
    private func indexForTask(id: UUID, in list: [CD_Task]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id}) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    private func showEdit(_ task: CD_Task) {
        let controller = storyboard?.instantiateViewController(identifier: EditViewController.identifier) as! EditViewController
        controller.task = task
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createNewTask() -> CD_Task {
        let task = CoreDataManager.shared.createTask()
        
        allTasks.insert(task, at: 0)
        taskCTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return task
    }
    
    private func fetchTasksFromStrage() {
        allTasks = CoreDataManager.shared.fetchTasks()
    }
    
    private func deleteTaskFromStorage(_ task: CD_Task) {
        
        deleteTask(with: task.id!)
        CoreDataManager.shared.deleteTaskCDM(task)
    }
    
    private func searchTasksFromStorage(_ text: String) {
        
    }
    
}
extension Task_C_ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showEdit(filteredTasks[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCCell", for: indexPath)
        let task = filteredTasks[indexPath.row]
        cell.textLabel?.text = task.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTaskFromStorage(filteredTasks[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension Task_C_ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchTasksFromStorage(query)
    }
    
    func search(_ query: String) {
        if query.count >= 1 {
            filteredTasks = allTasks.filter { $0.text!.lowercased().contains(query.lowercased()) }
        } else{
            filteredTasks = allTasks
        }
        
        taskCTableView.reloadData()
    }
}


extension Task_C_ViewController: TasksDelegate {
    
    func refreshTasks() {
      
        taskCTableView.reloadData()
    }
    
    func deleteTask(with id: UUID) {
        let indexPath = indexForTask(id: id, in: filteredTasks)
        filteredTasks.remove(at: indexPath.row)
        taskCTableView.deleteRows(at: [indexPath], with: .automatic)
        
        allTasks.remove(at: indexForTask(id: id, in: allTasks).row)
    }
}
