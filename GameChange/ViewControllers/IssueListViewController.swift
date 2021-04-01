//
//  ViewController.swift
//  TableView
//
//  Created by Deeksha Kaul on 03/10/18.
//  Copyright © 2018 Deeksha Kaul. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let maxCharecterLength = 140

    let tableView = UITableView()
    let viewModel = IssueListViewModel()
    
    var issueList: [IssueObject] = []
    var data: NSArray = []
    
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        setTableViewConstraints()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "IssuesListController.Navbar.Title".localizedValue()
        tableView.register(TwoLabelTableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.tableFooterView = UIView()
        callAPI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
            let tableview = tableView as UIView
            tableview.setConstraintsToEdge(with: self.view,
                                           left: LayoutConstants.padding1x,
                                           right: -LayoutConstants.padding1x,
                                           top: LayoutConstants.padding1nHalfx,
                                           botton: -LayoutConstants.padding1nHalfx)
    }
    
    func callAPI() {
        viewModel.fetchIssues(completion: { results in
            self.data = results
            for result in results {
                let data = result as! NSDictionary
                let issue = IssueObject()

                issue.title = data["title"] as? String
                issue.body = data["body"] as? String
                let url = data["comments_url"] as! String
                issue.commentUrl = url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                self.issueList.append(issue)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fetchDetailsAndPush(index: indexPath.row)
    }
    
    func fetchDetailsAndPush(index: Int) {
        let url = issueList[index].commentUrl
        let detailsViewController = IssueDetailsViewController()
        let detailsViewModel = IssueDetailsViewModel()
        detailsViewModel.fetchIssueDetails(url: url, completion: { [weak self] results in
            guard let self = self else { return }
            detailsViewController.issueDetails = results
            if results.count > 0 {
                self.navigateToDetailsPage(viewController: detailsViewController)
            } else {
                self.showAlert()
            }
        })
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No.Comments.Alert.Title".localizedValue(), message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close.Button".localizedValue(),
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    func navigateToDetailsPage(viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TwoLabelTableViewCell
        let cellObject = TwoLabelCellObject()
        cellObject.firstText = issueList[indexPath.row].title
        cellObject.secondText = issueList[indexPath.row].body?.maxLength(length: maxCharecterLength)
        cell.configureCell(cellObject: cellObject)
        cell.selectionStyle = .none
        return cell
    }
    
}

