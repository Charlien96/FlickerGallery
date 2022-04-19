//
//  PhotoSearchResponce.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation

// MARK: - PhotoSearchResonce.swift
struct PhotoSearchResonce: Decodable {
    let photos: Photos
}

// MARK: - Photos
struct Photos: Decodable {
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
}
