//
//  ViewController.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import UIKit

protocol IView: AnyObject {
    func reloadData()
}

final class ViewController: UIViewController {
    
    // UI
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(
            CharacterCell.self,
            forCellReuseIdentifier: String(describing: CharacterCell.self)
        )
        view.rowHeight = 80
        return view
    }()
    
    // Dependencies
    private let presenter: IPresenter
    
    // MARK: - Initialization
    
    init(presenter: IPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - IView

extension ViewController: IView {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CharacterCell.self),
            for: indexPath
        ) as? CharacterCell else { return UITableViewCell() }
        
        let model = presenter.dataSource[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        presenter.willDisplayCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
