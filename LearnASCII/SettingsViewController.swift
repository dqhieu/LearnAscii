//
//  SettingsViewController.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/31/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NumberOfQuizCellDelegate, TimePickerCellDelegate, AsciiSystemCellDelegate {

    var tableView: UITableView!
    
    func initTableView() {
        tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.white
        title = "Settings"
        
        let leftButton = UIButton(type: .system)
        leftButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        leftButton.setTitle("Close", for: .normal)
        leftButton.setTitleColor(UIColor.black, for: .normal)
        leftButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    
    func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = NumberOfQuizCell()
            cell.setup()
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = TimePickerCell()
            cell.setup()
            cell.delegate = self
            return cell
        } else if indexPath.row == 2 {
            let cell = AsciiSystemCell()
            cell.setup()
            cell.delegate = self
            return cell
        }
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func didPickTime(minutes: Int) {
        GameSettings.shared.setTime(time: minutes)
    }
    
    func didChooseNumberOfQuiz(nQuiz: Int) {
        GameSettings.shared.setNumberOfQuiz(nQuiz: nQuiz)
    }
    
    func didPickAsciiSystem(system: AsciiSystem) {
        GameSettings.shared.setAsciiSystem(system: system)
    }
}
