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
        tableView.separatorStyle = .singleLine
        setTableViewConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setTableViewConstraints()
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "IssuesDetailsController.Navbar.Title".localizedValue()
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
    
    func setTableViewConstraints() {
        let tableview = tableView as UIView
        tableview.setConstraintsToEdge(with: self.view,
                                       left: LayoutConstants.padding1x,
                                       right: -LayoutConstants.padding1x,
                                       top: LayoutConstants.padding1nHalfx,
                                       botton: -LayoutConstants.padding1nHalfx)
    }
    
}
