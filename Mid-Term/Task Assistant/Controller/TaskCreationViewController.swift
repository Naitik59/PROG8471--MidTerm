//
//  TaskCreationViewController.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 24/06/24.
//

import UIKit

class TaskCreationViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var categoryBtn: UIButton!
    
    var selectedCategory: TaskCategory = .academic
    var categoryImage: String = "graduationcap.fill"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Task Creation"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        addCategoryMenu()
    }
    
    @IBAction func addTaskDidTapped(_ sender: UIButton) {
        addTask()
    }
    
    private func addCategoryMenu() {
        
        let academic = UIAction(title: "Academic",
          image: UIImage(systemName: "graduationcap.fill")) { _ in
            self.configureCategoryBtn(with: "Academic", and: "graduationcap.fill", category: .academic)
        }
        
        let house = UIAction(title: "House",
          image: UIImage(systemName: "house.fill")) { _ in
            self.configureCategoryBtn(with: "House", and: "house.fill", category: .house)
        }
        
        let sport = UIAction(title: "Sport",
          image: UIImage(systemName: "soccerball.inverse")) { _ in
            self.configureCategoryBtn(with: "Sport", and: "soccerball.inverse", category: .sport)
        }
        
        let work = UIAction(title: "Work",
          image: UIImage(systemName: "laptopcomputer")) { _ in
            self.configureCategoryBtn(with: "Work", and: "laptopcomputer", category: .work)
        }
        
        let cooking = UIAction(title: "Cooking",
          image: UIImage(systemName: "frying.pan.fill")) { _ in
            self.configureCategoryBtn(with: "Cooking", and: "frying.pan.fill", category: .cooking)
        }

        categoryBtn.showsMenuAsPrimaryAction = true
        categoryBtn.menu = UIMenu(title: "", children: [academic, house, sport, work, cooking])
    }
    
    private func addTask() {
        if titleTextField.text == "" || descriptionTextField.text == "" {
            presentAlert(errorMessage: "Please enter all the required fields!")
        } else {
            let title = titleTextField.text ?? ""
            let description = descriptionTextField.text ?? ""
            let dueDate = dueDatePicker.date
            let priority = priority(for: prioritySegment.selectedSegmentIndex)
            
            let task = Task(title: title, description: description, image: categoryImage, dueDate: dueDate, priority: priority, status: .pending, category: selectedCategory)
            CoreDataMethods.shared.addUpdateCurrentTime(task: task)
        }
    }
    
    private func priority(for index: Int) -> Priority {
        switch index {
        case 0:
            return .low
        case 1:
            return .medium
        case 2:
            return .high
        default:
            return .low
        }
    }
    
    private func presentAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertController, animated: true)
    }
    
    private func configureCategoryBtn(with title: String, and image: String, category: TaskCategory) {
        self.categoryBtn.setTitle(title, for: .normal)
        self.categoryBtn.setImage(UIImage(systemName: image), for: .normal)
        self.selectedCategory = category
        self.categoryImage = image
    }
}
