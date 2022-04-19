//
//  SearchTableViewDataSource.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation
import UIKit

protocol SearchTableViewDataSourceOutputs: AnyObject {
    func didSelect(_ photo: PhotoRecord)
    func refreshTableView(at indexPath: IndexPath)
}

final class SearchTableViewDataSource: TableViewItemDataSource {

    private var entities: [PhotoRecord]?
    private weak var presenter: SearchTableViewDataSourceOutputs?
    let pendingOperations = PendingOperations()

    init(entities: [PhotoRecord]?, presenter: SearchTableViewDataSourceOutputs) {
        self.entities = entities
        self.presenter = presenter
    }

    var numberOfItems: Int {
        return entities?.count ?? 0
    }

    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let photo = entities?[safe: indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! ImageSearchTableViewCell
        cell.titleLbl?.text = photo.name
        switch (photo.state) {
        case .failed:
            print("Filed to download Image")
        case .new :
              startDownload(for: photo, at: indexPath)
          
        case .downloaded :
            cell.searchImageView.image = photo.image
        }
        
        return cell
    }

    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedPhoto = entities?[safe: indexPath.row] else { return }
        presenter?.didSelect(selectedPhoto)
    }

    func startDownload(for photoRecord: PhotoRecord, at indexPath: IndexPath) {
      guard pendingOperations.downloadsInProgress[indexPath] == nil else {
        return
      }
      
      let downloader = ImageDownloader(photoRecord)
      downloader.completionBlock = {
        if downloader.isCancelled {
          return
        }
        
        DispatchQueue.main.async {
          self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            
            
            self.presenter?.refreshTableView(at: indexPath)
        }
      }
      pendingOperations.downloadsInProgress[indexPath] = downloader
      pendingOperations.downloadQueue.addOperation(downloader)
    }
}
