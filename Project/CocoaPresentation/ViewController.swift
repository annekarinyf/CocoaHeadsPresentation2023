//
//  ViewController.swift
//  CocoaPresentation
//
//  Created by Anne Freitas on 30/10/23.
//

import UIKit

final class ViewController: UIViewController {
    private let storage: DataStorage
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private(set) lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Erro."
        label.isHidden = true
        return label
    }()
    
    private var cats = [Cat]()
    
    init(storage: DataStorage) {
        self.storage = storage
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Cats"
        setupLayout()
        loadData()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        setupTableView()
        setupErrorMessage()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func setupErrorMessage() {
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func loadData() {
        storage.load { result in
            switch result {
            case .success(let cats):
                self.cats = cats
                self.tableView.reloadData()
                self.errorLabel.isHidden = true
            case .error:
                self.errorLabel.isHidden = false
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = cats[indexPath.row].name
        cell.imageView?.image = cats[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
}

