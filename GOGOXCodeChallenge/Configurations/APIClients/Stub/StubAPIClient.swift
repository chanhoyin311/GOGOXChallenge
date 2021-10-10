//
//  StubAPIClient.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation
import WayPointJourney
import Models

class StubAPIClient: WayPointJourney.WayPointAPIStrategy {
    enum APIType {
        case fetchLocations

        var jsonFile: String {
            switch self {
            case .fetchLocations:
                return "FetchLocations"
            }
        }
    }

    func fetchLocation(
        by searchString: String,
        completion: @escaping ((Result<[Location], APIError>) -> Void)
    ) {
        genericFetchJson(apiType: .fetchLocations, completion: completion)
    }
}


extension StubAPIClient {
    func genericFetchJson<T: Codable>(
        apiType: APIType,
        completion: ((Swift.Result<T, APIError>) -> Void)
    ) {
        do {
            if let bundlePath = Bundle.main.path(forResource: apiType.jsonFile, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let data = try JSONDecoder().decode(
                    T.self,
                    from: jsonData)
                completion(.success(data))
            }
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            completion(.failure(.noNetwork))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.noNetwork))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.noNetwork))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.noNetwork))
        } catch {
            print("error: ", error)
            completion(.failure(.noNetwork))
        }
    }
}
