//
//  LookupViewController.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/29/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

class LookupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var tableView: UITableView!
    var searchBar: UISearchBar!
    var isSearching = false
    var filterResult:[String] = []
    
    
    func initTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    func initSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        searchBar.delegate = self
        searchBar.placeholder = "Enter characters. Ex: A b ! 2 e [SPACE]"
        tableView.tableHeaderView = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.white
        title = "ASCII TABLE"
        
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
        initSearchBar()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterResult.count
        }
        return AsciiTable.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if isSearching {
            cell.textLabel?.text = filterResult[indexPath.row]
        } else {
            cell.textLabel?.text = "\(AsciiTable.shared.getHex(at: indexPath.row)):   \(AsciiTable.shared.getChar(at: indexPath.row))"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterResult.removeAll()
        if searchText == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            let searchTexts = searchText.components(separatedBy: " ")
            for text in searchTexts {
                if let index = AsciiTable.shared.indexOf(char: text) {
                    filterResult.append("\(AsciiTable.shared.getHex(at: index)):   \(AsciiTable.shared.getChar(at: index))")
                }
            }
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        isSearching = false
        filterResult.removeAll()
        tableView.reloadData()
    }
}
