//
//  QuoteOfTheDay.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let quoteOfTheDay = try QuoteOfTheDay(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.quoteOfTheDayTask(with: url) { quoteOfTheDay, response, error in
//     if let quoteOfTheDay = quoteOfTheDay {
//       ...
//     }
//   }
//   task.resume()

import Foundation
import UIKit

typealias QuoteOfTheDay = [QuoteOfTheDayElement]

struct QuoteOfTheDayElement: Codable {
    let id: Int
    let title: String
    let content: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "title"
        case content = "content"
        case link = "link"
    }
}

// MARK: Convenience initializers and mutators

extension QuoteOfTheDayElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(QuoteOfTheDayElement.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int? = nil,
        title: String? = nil,
        content: String? = nil,
        link: String? = nil
        ) -> QuoteOfTheDayElement {
        return QuoteOfTheDayElement(
            id: id ?? self.id,
            title: title ?? self.title,
            content: content ?? self.content,
            link: link ?? self.link
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Array where Element == QuoteOfTheDay.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(QuoteOfTheDay.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func quoteOfTheDayTask(with url: URL, completionHandler: @escaping (QuoteOfTheDay?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
