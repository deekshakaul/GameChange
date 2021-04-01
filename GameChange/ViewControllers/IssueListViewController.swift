//
//  ViewController.swift
//  TableView
//
//  Created by Deeksha Kaul on 03/10/18.
//  Copyright © 2018 Deeksha Kaul. All rights reserved.
//

import UIKit
import RealmSwift

class IssueListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let maxCharecterLength = 140
    
    let twentyFourHrsDifference = Double(-24*60*60)

    let tableView = UITableView()
    let viewModel = IssueListViewModel()
    
    var issueList: [IssueObject] = []
    var data: NSArray = []
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }

    func isDataOutDated() -> Bool {
        guard let timeStamp = RealmManager.realm().objects(IssueObject.self).first?.updatedTimeStamp else { return true }
        return timeStamp.timeIntervalSinceNow < self.twentyFourHrsDifference
    }
    
    func isCommentDataOutDated() -> Bool {
        guard let timeStamp = RealmManager.realm().objects(CommentObject.self).first?.updatedTimestamp else { return true }
        return timeStamp.timeIntervalSinceNow < self.twentyFourHrsDifference
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDataOutDated() {
            callAPI()
        } else{
            fetchDataFromRealm()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "IssuesListController.Navbar.Title".localizedValue()
        tableView.register(TwoLabelTableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.tableFooterView = UIView()
    }

    func fetchDataFromRealm() {
        let results = RealmManager.realm().objects(IssueObject.self)
        for result in results {
            issueList.append(result)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
            RealmManager.deleteAll()
            self.issueList = results
            DispatchQueue.main.async {
                RealmManager.add(objects: self.issueList)
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
            guard let detailsViewController = viewController as? IssueDetailsViewController else { return }
            RealmManager.add(objects: detailsViewController.issueDetails)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueList.count
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

