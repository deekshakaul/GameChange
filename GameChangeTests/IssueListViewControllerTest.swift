//
//  File.swift
//  GameChangeTests
//
//  Created by Deeksha Kaul on 01/04/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

@testable import GameChange
import XCTest

class IssueListViewControllerTest: XCTestCase {
    
    var viewController: IssueListViewController!
    var detailsViewController: IssueDetailsViewController!

    override func setUp() {
        super.setUp()
        viewController = IssueListViewController()
        detailsViewController = IssueDetailsViewController()
    }
    
    func testViewController() {
        viewController.callAPI()
        // adding delay to wait for API call to complete. Ideally will have local mock data so won't be required
        sleep(5)
        XCTAssertGreaterThan(viewController.issueList.count, 0)
        XCTAssertNotNil(viewController.issueList.first?.title)
        viewController.fetchDetailsAndPush(index: 1)
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

}
