//
//  SettingsViewController.swift
//  Task Assistant
//
//  Created by Naitik Ratilal Patel on 09/07/24.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var ascendingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureSwitch()
    }
    
    private func configureSwitch() {
        ascendingSwitch.addTarget(self, action: #selector(switchOnOff), for: .valueChanged)
    }
    
    @objc func switchOnOff(_ sender: UISwitch) {
        sortingType = sender.isOn ? .ascending : .descending
    }
    
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filterType = .all
        case 1:
            filterType = .low
        case 2:
            filterType = .medium
        case 3:
            filterType = .high
        default:
            break
        }
    }
    
    @IBAction func filterByStatusChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filterByStatus = .all
        case 1:
            filterByStatus = .pending
        case 2:
            filterByStatus = .completed
        default:
            break
        }
    }
    
    private func setupView() {
        self.title = "Settings"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}
