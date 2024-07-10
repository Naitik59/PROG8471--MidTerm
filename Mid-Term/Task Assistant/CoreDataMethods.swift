//
//  CoreDataMethods.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 09/07/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataMethods {
    
    static let shared = CoreDataMethods()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func addUpdateCurrentTime(task: Task) {
        if let managedContext = appDelegate?.persistentContainer.viewContext {
            
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "TaskItem")
            fetchRequest.predicate = NSPredicate(format: "title = %@", task.title)
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                
                if let result = result as? [NSManagedObject],
                   let fetchedTitle = result.first?.value(forKey: "title") as? String, fetchedTitle == task.title {
                    result[0].setValue(task.status == .pending ? false : true, forKey: "status")
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "TaskItem", in: managedContext)!
                    
                    let data = NSManagedObject(entity: entity, insertInto: managedContext)
                    data.setValue(task.title, forKey: "title")
                    data.setValue(task.status == .pending ? false : true, forKey: "status")
                    data.setValue(task.description, forKey: "taskDescription")
                    data.setValue(task.priority.rawValue, forKey: "priority")
                    data.setValue(task.dueDate, forKey: "due")
                    data.setValue(task.category.rawValue, forKey: "category")
                    data.setValue(task.image, forKey: "image")
                }
                
                try managedContext.save()
                
            } catch let error as NSError {
                print("🆘 Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchTasks() -> [Task] {
        
        if let managedContext = appDelegate?.persistentContainer.viewContext {
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskItem")
            
            do {
                let tasks = try managedContext.fetch(fetchRequest)
                
                var taskItems: [Task] = []
                
                for task in tasks {
                    let title = task.value(forKey: "title") as? String ?? ""
                    let description = task.value(forKey: "taskDescription") as? String ?? ""
                    let dueDate = task.value(forKey: "due") as? Date ?? Date()
                    let image = task.value(forKey: "image") as? String ?? ""
                    
                    let priority = checkPriority(for: (task.value(forKey: "priority") as? String) ?? "")
                    let status = task.value(forKey: "status") as? Bool == true ? TaskStatus.completed : TaskStatus.pending
                    let category = checkCategory(for: (task.value(forKey: "category") as? String) ?? "")
                    
                    let item = Task(title: title, description: description, image: image, dueDate: dueDate, priority: priority, status: status, category: category)
                    
                    taskItems.append(item)
                }
                
                return taskItems
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return []
    }
    
    private func checkCategory(for categoryStr: String) -> TaskCategory {
        
        if categoryStr == TaskCategory.house.rawValue {
            return .house
        } else if categoryStr == TaskCategory.academic.rawValue {
            return .academic
        } else if categoryStr == TaskCategory.sport.rawValue {
            return .sport
        } else if categoryStr == TaskCategory.cooking.rawValue {
            return .cooking
        } else {
            return .work
        }
    }
    
    private func checkPriority(for priorityStr: String) -> Priority {
        
        if priorityStr == Priority.low.rawValue {
            return .low
        } else if priorityStr == Priority.medium.rawValue {
            return .medium
        } else {
            return .high
        }
    }
}
