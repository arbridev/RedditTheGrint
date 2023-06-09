//
//  String+Validation.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 17/5/23.
//

import Foundation

extension String {
    /// Reference: https://stackoverflow.com/a/49072718/5691990
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
