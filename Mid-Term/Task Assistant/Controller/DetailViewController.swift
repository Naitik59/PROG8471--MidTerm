//
//  DetailViewController.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 09/07/24.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func taskStatusChanged(to status: TaskStatus?, at index: Int)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var markBtn: UIButton!
    
    var task: Task?
    var index: Int = 0
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func markAsCompletedDidTapped(_ sender: UIButton) {
        if task?.status == .pending {
            task?.status = .completed
            markBtn.setTitle("Mark As Incomplete", for: .normal)
        } else {
            task?.status = .pending
            markBtn.setTitle("Mark As Complete", for: .normal)
        }
        
        self.statusLbl.text = "Status: \(task?.status.rawValue ?? "")"
        
        if let task = task {
            CoreDataMethods.shared.addUpdateCurrentTime(task: task) { success in }
        }
    }
    
    private func setupView() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.titleLbl.text = task?.title
        self.categoryImg.image = UIImage(systemName: task?.image ?? "")
        self.descriptionLbl.text = task?.description
        self.statusLbl.text = "Status: \(task?.status.rawValue ?? "")"
        
        if let date = task?.dueDate {
            self.subtitleLbl.text = "• \(task?.priority.rawValue ?? "") • Due on \(formate(date: date))"
        }
    }
}
