//
//  SearchRouterOutput.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation
import UIKit

struct SearchRouterInput {

    func view(searchHubApi: ApiType) -> ImageSearchViewController {
        
        let sb = UIStoryboard(name:"Main", bundle:nil)
        
        let view = sb.instantiateViewController(withIdentifier: "ImageSearchViewController") as! ImageSearchViewController
        let interactor = ImageSearchInteractor(searchHubApi: searchHubApi)
        let dependencies = ListPresenterDependencies(interactor: interactor, router: SearchRouterOutput(view))
        let presenter = ImageSearchPresenter(entities: nil, view: view, dependencies: dependencies)
        view.presenter = presenter
        view.tableViewDataSource = SearchTableViewDataSource(entities: presenter.entities, presenter: presenter)
        interactor.presenter = presenter
        return view
    }
}

final class SearchRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

    func transitionDetail(photo: PhotoRecord) {

    }
}
