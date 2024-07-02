//
//  LanguageSelectionViewController.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

final class LanguagesListView: UIViewController {
    
    let identifier = "cell"
    var router: TranslateRouterInput?
    
    private lazy var languagesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemYellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setDelegates()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(languagesTableView)
    }
    
    private func setDelegates() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension LanguagesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = languages[indexPath.row].name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LanguagesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.didSelectLanguage(languages[indexPath.row].name)
        dismiss(animated: true)
    }
}

//MARK: Constraints
private extension LanguagesListView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            languagesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            languagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            languagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languagesTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
