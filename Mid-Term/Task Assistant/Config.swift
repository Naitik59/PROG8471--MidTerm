//
//  Config.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 09/07/24.
//

import Foundation

enum Priority: String {
    case all = "All"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum Sort {
    case ascending
    case descending
}

enum TaskStatus: String {
    case all = "All"
    case pending = "Pending"
    case completed = "Completed"
}

enum TaskCategory: String {
    case house = "House"
    case cooking = "Cooking"
    case sport = "Sport"
    case work = "Work"
    case academic = "Academic"
}

var sortingType: Sort = .ascending
var filterType: Priority = .all
var filterByStatus: TaskStatus = .all

func formate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    let month = formatter.string(from: date)
    formatter.dateFormat = "dd"
    let day = formatter.string(from: date)
    
    return "\(day)/\(month)"
}
