//
//  ListViewController.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 24/06/24.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var taskListTableView: UITableView!
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTaskData()
    }
    
    private func setupView() {
        self.title = "List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTable() {
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.separatorStyle = .none
    }
    
    private func fetchTaskData() {
        
        tasks.removeAll()
        
        var taskItems = CoreDataMethods.shared.fetchTasks()
        
        if filterType == .low {
            taskItems = taskItems.filter { $0.priority == .low }
        } else if filterType == .medium {
            taskItems = taskItems.filter { $0.priority == .medium }
        } else if filterType == .high {
            taskItems = taskItems.filter { $0.priority == .high }
        }
        
        if filterByStatus == .completed {
            taskItems = taskItems.filter { $0.status == .completed }
        } else if filterByStatus == .pending {
            taskItems = taskItems.filter { $0.status == .pending }
        }
        
        if sortingType == .ascending {
            taskItems.sort { $0.title < $1.title }
        } else {
            taskItems.sort { $0.title > $1.title }
        }
        
        tasks.append(contentsOf: taskItems)
        
        DispatchQueue.main.async {
            self.taskListTableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        cell.configureCell(for: tasks[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        vc.task = tasks[indexPath.row]
        vc.index = indexPath.row
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListViewController: TaskTableViewCellDelegate {
    
    func changeTaskStatus(at index: Int, to status: TaskStatus) {
        
        DispatchQueue.main.async {
            self.tasks[index].status = status
            CoreDataMethods.shared.addUpdateCurrentTime(task: self.tasks[index])
            self.fetchTaskData()
        }
    }
}

extension ListViewController: DetailViewControllerDelegate {
    
    func taskStatusChanged(to status: TaskStatus?, at index: Int) {
        DispatchQueue.main.async {
            if let status = status {
                self.tasks[index].status = status
                self.taskListTableView.reloadData()
            }
        }
    }
}
