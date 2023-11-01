//
//  ViewControllerTests2.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

import UIKit
import XCTest
@testable import CocoaPresentation

final class ViewControllerTests: XCTestCase {
    //
    // 1 - Um teste para verificar se quando VC é carregada, o título é setado
    //
    func test_viewDidLoad_setsTitle() {
        let (sut, _) = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "My Cats")
    }
    
    //
    // 2 - Testar se imediatamente após carregar a tela, antes do viewDidLoad, nenhum dado é exibido
    // Observar que com esse teste também acabamos testando o data source da Table View
    func test_viewDidLoad_setTableViewInitialState() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    //
    // 3 - Testar se carrega os gatos da API
    //
    func test_viewDidLoad_whenLoadSuccessfully_rendersCatsFromAPI() {
        let (sut, dataStorageSpy) = makeSUT()
        
        let cat1 = Cat(name: "Nina", image: UIImage())
        let cat2 = Cat(name: "Bob", image: UIImage())
        
        dataStorageSpy.loadResultToBeReturned = .success([cat1, cat2])
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
        
        // Adicionalmente podemos testar os valores das cells
        let cell1 = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? UITableViewCell
        XCTAssertEqual(cell1?.textLabel?.text, cat1.name)
        XCTAssertEqual(cell1?.imageView?.image, cat1.image)
        
        let cell2 = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? UITableViewCell
        XCTAssertEqual(cell2?.textLabel?.text, cat2.name)
        XCTAssertEqual(cell2?.imageView?.image, cat2.image)
    }
    
    func test_viewDidLoad_whenLoadsWithError_showsErrorMessage() {
        let (sut, dataStorageSpy) = makeSUT()
        
        dataStorageSpy.loadResultToBeReturned = .error(nil)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut.errorLabel.isHidden, false)
        XCTAssertEqual(sut.errorLabel.text, "Erro.")
    }
    
    func makeSUT() -> (ViewController, DataStorageSpy) {
        let dataStorageSpy = DataStorageSpy()
        let sut = ViewController(storage: dataStorageSpy)
        
        return (sut, dataStorageSpy)
    }
}
