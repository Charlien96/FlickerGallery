//
//  FakeApiTask.swift
//  FlickerGalleryTests
//
//  Created by Admin on 19/04/2022.
//

import Foundation
@testable import FlickerGallery


class FakeApiTask: ApiType {
    func search(with request: SearchRequest, completion: @escaping ((Result<PhotoSearchResonce, ApiError>) -> Void)) {

        let bundle = Bundle(for:FakeApiTask.self)
        guard let url = bundle.url(forResource:request.searchedText, withExtension:"json"),
              let data = try? Data(contentsOf: url) else {
                  completion(.failure(ApiError.recieveNilResponse))
                  return
              }

        do {
            let decodedResopnce = try JSONDecoder().decode(PhotoSearchResonce.self, from: data)
            completion(.success(decodedResopnce))

        }catch {
            completion(.failure(ApiError.failedParse))
        }

    }
}
