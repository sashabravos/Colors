//
//  ColorListViewController.swift
//  Colors
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class ColorListViewController: UIViewController {

    private let tableview = UITableView()
    private let presenter: ColorListPresenterProtocol = ColorListPresenter()
    
    private let cellIdentifier = "ColorCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setView(self)
        setupTable()
    }

    private func setupTable() {
        self.view.addSubview(tableview)
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.tableview.register(UITableViewCell.self,
                                forCellReuseIdentifier: cellIdentifier)
        self.tableview.frame = view.frame
    }
}

    // MARK: - UITableViewDataSource

extension ColorListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let actionButton = UIButton()
        actionButton.setTitle(presenter.getTitleForActionButton(),
                              for: .normal)
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.addTarget(self,
                               action: #selector(actionButtonTapped),
                               for: .touchUpInside)
        return actionButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        let cellText = presenter.titleForRow(at: indexPath)
        
        if #available(iOS 14.0, *) {
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = cellText
            cell.contentConfiguration = contentConfiguration
        } else {
            cell.textLabel?.text = cellText
        }
        
        let colorRGB = presenter.backgroundColorForCell(at: indexPath)
        let customColor = UIColor(red: colorRGB.red,
                                  green: colorRGB.green,
                                  blue: colorRGB.blue, alpha: 0.9)
        
        cell.contentView.backgroundColor = customColor
        return cell
    }
    
    @objc private func actionButtonTapped() {
        presenter.actionButtonTapped()
    }
}

    // MARK: - UITableViewDelegate

extension ColorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectColor(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRowAt(indexPath: indexPath)
    }
}

    // MARK: - ColorListViewProtocol

extension ColorListViewController: ColorListViewProtocol {
    
    func reloadTable() {
        tableview.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        self.present(alert, animated: true)
    }
}
