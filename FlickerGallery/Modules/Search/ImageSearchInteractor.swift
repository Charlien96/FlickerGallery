//
//  ImageSearchInteractor.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation

protocol ImageSearchInteractorOutputs: AnyObject {
    func onSuccessSearch(res: [PhotoRecord])
    func onErrorSearch(error: Error)
}

final class ImageSearchInteractor: Interactorable {

    weak var presenter: ImageSearchInteractorOutputs?
    private var searchHubApi: ApiType
    init(searchHubApi: ApiType) {
        self.searchHubApi = searchHubApi
    }
    
    func fetchSearch(request:SearchRequest) {
        searchHubApi.search(with: request) {[weak self] result in
            switch result {
            case .success(let res):
                
               let photoRecords =  res.photos.photo.map {
                    PhotoRecord(name:$0.title, url: "\(ImageEndPoint.imagesBaseUrl)/\($0.server)/\($0.id)_\($0.secret)_w.jpg")
                }
                self?.presenter?.onSuccessSearch(res: photoRecords)
            case .failure(let error):
                self?.presenter?.onErrorSearch(error: error)
            }
        }
    }
}
