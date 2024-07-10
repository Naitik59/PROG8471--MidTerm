//
//  ToDoItem.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 09/07/24.
//

import Foundation

struct Task {
    let title: String
    let description: String
    let image: String
    let dueDate: Date
    let priority: Priority
    var status: TaskStatus
    let category: TaskCategory
}
