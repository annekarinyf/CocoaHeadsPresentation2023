//
//  NotificationViewControllerTests.swift
//  CocoaPresentationTests
//
//  Created by Anne Freitas on 01/11/23.
//

import XCTest
@testable import CocoaPresentation

import UserNotifications

protocol UserNotificationCenter {
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?)
}
extension UNUserNotificationCenter: UserNotificationCenter {}

final class NotificationViewController: UIViewController {
    private let notificationCenter: UserNotificationCenter
    
    init(notificationCenter: UserNotificationCenter) {
        self.notificationCenter = notificationCenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendNotification()
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}

class UserNotificationCenterSpy: UserNotificationCenter {
    
    private(set) var addCalled = false
    private(set) var addRequestContentTitlePassed = ""
    
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?) {
        addCalled = true
        addRequestContentTitlePassed = request.content.title
    }
}

final class NotificationViewControllerTests: XCTestCase {
    func test_whenViewDidLoad_shouldSendHelloNotification() {
        let notificationSpy = UserNotificationCenterSpy()
        let sut = NotificationViewController(notificationCenter: notificationSpy)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(notificationSpy.addCalled)
        XCTAssertEqual(notificationSpy.addRequestContentTitlePassed, "Hello!")
    }
}

//final class NotificationViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        sendNotification()
//    }
//    
//    private func sendNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Hello!"
//        content.sound = UNNotificationSound.default
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request)
//    }
//}
//
