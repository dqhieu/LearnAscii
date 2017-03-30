//
//  EndViewController.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/26/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

protocol EndViewControllerDelegate {
    func didTapPlayAgain()
    func didTapBackToMenu()
}

class EndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    var rightAnswer:[Int] = []
    var wrongAnswer:[Int] = []
    
    var delegate: EndViewControllerDelegate?
    
    func initTableView() {
        tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.white
        title = "Result"
        
        let leftButton = UIButton(type: .system)
        leftButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        leftButton.setTitle("Close", for: .normal)
        leftButton.setTitleColor(UIColor.black, for: .normal)
        leftButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let rightButton = UIButton(type: .system)
        rightButton.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        rightButton.setTitle("Test again", for: .normal)
        rightButton.setTitleColor(UIColor.black, for: .normal)
        rightButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    func didTapMenuButton() {
        self.dismiss(animated: false) {
            self.delegate?.didTapBackToMenu()
        }
    }
    
    func didTapPlayButton() {
        self.dismiss(animated: true) { 
            self.delegate?.didTapPlayAgain()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Right Answers: \(rightAnswer.count)"
        } else if section == 1 {
            return "Wrong Answers: \(wrongAnswer.count)"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return rightAnswer.count
        } else if section == 1 {
            return wrongAnswer.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            let text = "\(AsciiTable.shared.getHex(at: rightAnswer[indexPath.row])):   \(AsciiTable.shared.getChar(at: rightAnswer[indexPath.row]))"
            cell.textLabel?.text = text
        } else if indexPath.section == 1 {
            let text = "\(AsciiTable.shared.getHex(at: wrongAnswer[indexPath.row])):   \(AsciiTable.shared.getChar(at: wrongAnswer[indexPath.row]))"
            cell.textLabel?.text = text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
