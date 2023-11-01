//
//  String+Random.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

import Foundation

extension String {
    static func random(length: Int = 5) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
