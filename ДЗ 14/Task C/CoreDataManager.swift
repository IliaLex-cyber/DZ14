//
//  CoreDataManager.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 17.12.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "CoreDataModel")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("error while saving: \(error.localizedDescription)")
            }
            
        }
    }
}

extension CoreDataManager {
    func createTask() -> CD_Task {
        let task = CD_Task(context: CoreDataManager.shared.viewContext)
        task.id = UUID()
        task.text = ""
        save()
        return task
    }
    
    func fetchTasks() -> [CD_Task] {
        let request: NSFetchRequest<CD_Task> = CD_Task.fetchRequest()
        
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteTaskCDM(_ task: CD_Task) {
        viewContext.delete(task)
        save()
    }
}
