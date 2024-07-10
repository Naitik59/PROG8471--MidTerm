//
//  TaskTableViewCell.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 09/07/24.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func changeTaskStatus(at index: Int, to status: TaskStatus)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var priorityIndicatorView: UIView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var completeBtn: UIButton!
    
    var taskStatus: TaskStatus = .pending
    var index: Int = 0
    
    weak var delegate: TaskTableViewCellDelegate?
    
    func configureCell(for task: Task) {
        self.titleLbl.text = task.title
        self.statusLbl.text = task.status.rawValue
        self.dueDateLbl.text = formate(date: task.dueDate)
        self.priorityLbl.text = task.priority.rawValue
        self.taskStatus = task.status
        
        if task.status == .pending {
            completeBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            statusImage.image = UIImage(systemName: "clock")
        } else {
            completeBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            statusImage.image = UIImage(systemName: "checkmark.seal.fill")
        }
        
        if task.priority == .low {
            priorityIndicatorView.backgroundColor = UIColor.green
        } else if task.priority == .medium {
            priorityIndicatorView.backgroundColor = UIColor.orange
        } else {
            priorityIndicatorView.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func statusDidTapped(_ sender: UIButton) {
//        if taskStatus == .pending {
//            taskStatus = .completed
//            completeBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
//        } else {
//            taskStatus = .pending
//            completeBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
//        }
        
        taskStatus = taskStatus == .pending ? .completed : .pending
        self.delegate?.changeTaskStatus(at: index, to: taskStatus)
    }
}
