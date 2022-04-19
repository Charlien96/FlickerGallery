//
//  Collection.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
