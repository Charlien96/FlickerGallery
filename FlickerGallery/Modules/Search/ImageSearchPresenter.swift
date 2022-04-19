//
//  ImageSearchPresenter.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation

typealias ListPresenterDependencies = (
    interactor: ImageSearchInteractor,
    router: SearchRouterOutput
)

final class ImageSearchPresenter: Presenterable {

    var entities: [PhotoRecord]?
    private weak var view: SearchViewInputs!
    let dependencies: ListPresenterDependencies

    init(entities: [PhotoRecord]?,
         view: SearchViewInputs,
         dependencies: ListPresenterDependencies)
    {
        self.view = view
        self.entities = entities
        self.dependencies = dependencies
    }

}

extension ImageSearchPresenter: SearchViewOutputs {
    func viewDidLoad() {
        view.configure()
    }
    
    func search(for text:String) {
        let request = SearchRequest(searchedText:text)
        dependencies.interactor.fetchSearch(request: request)
    }
}

extension ImageSearchPresenter: ImageSearchInteractorOutputs {
    func onSuccessSearch(res: [PhotoRecord]) {
        
        self.entities = res
        view.reloadTableView(tableViewDataSource: SearchTableViewDataSource(entities: entities, presenter: self))
        view.indicatorView(animate: false)
    }

    func onErrorSearch(error: Error) {
        view.indicatorView(animate: false)
    }
}

extension ImageSearchPresenter: SearchTableViewDataSourceOutputs {
    func refreshTableView(at indexPath: IndexPath) {
        view.reloadTableView(at: indexPath)
    }
    
    func didSelect(_ photo: PhotoRecord) {
        dependencies.router.transitionDetail(photo: photo)
    }
}
