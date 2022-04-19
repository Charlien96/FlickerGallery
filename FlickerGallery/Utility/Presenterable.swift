//
//  Presenterable.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation

protocol Presenterable {
    //    associatedtype V: Viewable
    //    associatedtype I: Interactorable
    //    associatedtype R: Routerable
    //    associatedtype E: PresenterEntities
    //    var dependencies: (view: V, router: R, interactor: I, entities: E) { get }

    associatedtype I: Interactorable
    associatedtype R: Routerable
    var dependencies: (interactor: I, router: R) { get }
}
