//
//  APIClient+Extensions.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import Foundation

extension HTTPURLResponse {
    func requestDuration(from startTime: Date) -> TimeInterval {
        let endTime = Date()
        return endTime.timeIntervalSince(startTime)
    }
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])) as? [String: Any]
  }
}

extension Data{
    var utf8String: String {
        String(decoding: self, as: UTF8.self)
    }
}
