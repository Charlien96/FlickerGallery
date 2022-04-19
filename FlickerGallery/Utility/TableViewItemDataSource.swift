//
//  TableViewItemDataSource.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation
import UIKit

protocol TableViewItemDataSource: AnyObject {
    var numberOfItems: Int { get }

    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, indexPath: IndexPath)
}
