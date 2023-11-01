//
//  DataStorageSpy.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

@testable import CocoaPresentation

final class DataStorageSpy: DataStorage {
    
    private(set) var loadCalledCount = 0
    var loadResultToBeReturned: Result = .error(nil)
    
    func load(completion: @escaping (Result) -> Void) {
        loadCalledCount += 1
        completion(loadResultToBeReturned)
    }
}
