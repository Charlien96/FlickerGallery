//
//  SearchHubApi.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation


struct ImageEndPoint {
    static let imagesBaseUrl = "https://live.staticflickr.com/"
}
protocol ApiType {
    func search(with request: SearchRequest, completion:@escaping((Result<PhotoSearchResonce, ApiError>) -> Void))
}

struct SearchRequest: Request {
    private let baseUrl = "https://www.flickr.com/services/rest/"

    var url: String {
        return baseUrl
    }
    let searchedText: String
    
    func params() -> [(key: String, value: String)] {
        return [
            (key: "text", value: searchedText),
            (key: "api_key", value : "060c8bb57f264d10dc6463cce0a8f230"),
            (key: "nojsoncallback", value : "1"),
            (key: "format", value : "json"),
            (key: "method", value : "flickr.photos.search")

        ]
    }
}

struct SearchHubApi: ApiType {
  
    func search(with request: SearchRequest, completion: @escaping((Result<PhotoSearchResonce, ApiError>) -> Void)) {
       
        ApiTask().request(.get, request: request) { (data, session) in
            do {
                let response = try self.parse(data)
                completion(.success(response))
            } catch {
                completion(.failure(ApiError.failedParse))
            }
        } onError: { error in
            completion(.failure(ApiError.recieveNilResponse))
        }
    }
    private func parse(_ data: Data) throws -> PhotoSearchResonce {
        let response: PhotoSearchResonce = try JSONDecoder().decode(PhotoSearchResonce.self, from: data)
        return response
    }
}
