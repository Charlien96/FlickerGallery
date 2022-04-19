//
//  ImageSearchViewController.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation
import UIKit
import Combine

protocol SearchViewInputs: AnyObject {
    func configure()
    func reloadTableView(tableViewDataSource: SearchTableViewDataSource)
    func reloadTableView(at indexPath:IndexPath)
    func indicatorView(animate: Bool)
}

protocol SearchViewOutputs: AnyObject {
    var entities: [PhotoRecord]? { get }
    var dependencies: ListPresenterDependencies { get }
    func viewDidLoad()
    func search(for text:String)
}

final class ImageSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    internal var presenter: SearchViewOutputs?
    internal var tableViewDataSource: TableViewItemDataSource?
    private var subscribers = Set<AnyCancellable>()

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension ImageSearchViewController: SearchViewInputs {
    func reloadTableView(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    func configure() {
        navigationItem.title = "Flicker Search"
        setupSearchBarListener()
    }

    func setupSearchBarListener() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
        
        publisher
            .map {
                ($0.object as! UISearchTextField).text!
            }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchedText in
              
                self?.presenter?.search(for: searchedText)
                print(searchedText)
            }.store(in: &subscribers)

      }
    func reloadTableView(tableViewDataSource: SearchTableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
            self?.searchBar?.resignFirstResponder()
        }
    }

    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: animate ? 50 : 0, right: 0)
            _ = animate ? self?.indicatorView?.startAnimating() : self?.indicatorView?.stopAnimating()
        }
    }
}

extension ImageSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }
}

extension ImageSearchViewController: Viewable {}
