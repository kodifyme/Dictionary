//
//  HistoryView.swift
//  Dictionary
//
//  Created by KOДИ on 04.07.2024.
//

import UIKit

protocol HistoryViewInput {
    var output: HistoryViewOutput? { get set }
    func updateData(_ items: [String])
}

protocol HistoryViewOutput {
    func searchTextDidChange(_ searchText: String)
}

class HistoryView: UIViewController, HistoryViewInput {
    
    var output: HistoryViewOutput?
    private let identifier = "cell"
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search"
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    private lazy var historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemYellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        setDelegates()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(historyTableView)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "History"
        navigationController?.navigationBar.barTintColor = .systemYellow
        navigationItem.searchController = searchController
    }
    
    private func setDelegates() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    
    func updateData(_ items: [String]) {
        historyTableView.reloadData()
    }
}

//MARK: - UISearchResultsUpdating
extension HistoryView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        output?.searchTextDidChange(searchText)
    }
}

//MARK: - UITableViewDataSource
extension HistoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "wfw"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HistoryView: UITableViewDelegate {
    
}

//MARK: - Constraints
private extension HistoryView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.topAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            historyTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
