//
//  Extensions.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 14/03/24.
//

import Foundation

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
