//
//  DependecyInversionExample.swift
//  CocoaPresentation
//
//  Created by Anne Freitas on 30/10/23.
//

import UIKit

struct User {
    let name: String
}

class CoreDataStack {
    func getUsers(completion: (([User]) -> Void)) { completion([]) }
}

final class HomeController {
    private let tableView = UITableView()
    
    func reloadData() {
        CoreDataStack().getUsers { users in
            tableView.reloadData()
        }
    }
}

protocol CoreDataProtocol {
    func getUsers(completion: (([User]) -> Void))
}

extension CoreDataStack: CoreDataProtocol {}

final class NewHomeController {
    private let tableView = UITableView()
    
    private let coreData: CoreDataProtocol
    
    init(coreData: CoreDataProtocol) {
        self.coreData = coreData
    }
    
    func reloadData() {
        coreData.getUsers { users in
            tableView.reloadData()
        }
    }
}
