//
//  InMemoryStorage.swift
//  CocoaPresentation
//
//  Created by Anne Freitas on 01/11/23.
//

import Foundation
import UIKit

enum Result {
    case success([Cat])
    case error(Error?)
}

protocol DataStorage {
    func load(completion: @escaping (Result) -> Void)
}

final class InMemoryStorage: DataStorage {
    func load(completion: @escaping (Result) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success([
                Cat(name: "Chocolate", image: UIImage(named: "chocolate")!),
                Cat(name: "Luna", image: UIImage(named: "luna")!),
                Cat(name: "Pipilito", image: UIImage(named: "pipilito")!),
                Cat(name: "Gohan", image: UIImage(named: "gohan")!),
                Cat(name: "Shin Ha-Ri", image: UIImage(named: "shinhari")!),
            ]))
        }
    }
}
