//
//  IssueDetailsViewController.swift
//  TableView
//
//  Created by Deeksha Kaul on 31/03/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import UIKit

class IssueDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var viewModel: IssueDetailsViewModel? = nil
    
    private var data: NSArray = []
    
    var issueDetails: [CommentObject] = []
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true
        view.addSubview(tableView)
        tableView.frame = self.view.frame
        tableView.separatorStyle = .singleLine
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Issues"
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(TwoLabelTableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TwoLabelTableViewCell
        let cellObject = TwoLabelCellObject()
        cellObject.firstText = self.issueDetails[indexPath.row].userName
        cellObject.secondText = self.issueDetails[indexPath.row].body
        cell.configureCell(cellObject: cellObject)
        cell.selectionStyle = .none
        return cell
    }
    
}
