import Combine
import SwiftUI
import XCTest

@testable import Hooks

final class UsePublisherSubscribeTests: XCTestCase {
    func testUpdate() {
        let subject = PassthroughSubject<Void, URLError>()
        var value = 0
        let tester = HookTester {
            usePublisherSubscribe {
                subject.map { value }
            }
        }

        XCTAssertEqual(tester.value.phase, .pending)

        tester.value.subscribe()

        XCTAssertEqual(tester.value.phase, .running)

        subject.send()

        XCTAssertEqual(tester.value.phase.value, 0)

        value = 1
        tester.value.subscribe()
        subject.send()

        XCTAssertEqual(tester.value.phase.value, 1)

        value = 2
        tester.value.subscribe()
        subject.send()

        XCTAssertEqual(tester.value.phase.value, 2)
    }

    func testUpdateFailure() {
        let subject = PassthroughSubject<Void, URLError>()
        let tester = HookTester(0) { value in
            usePublisherSubscribe {
                subject.map { value }
            }
        }

        XCTAssertEqual(tester.value.phase, .pending)

        tester.value.subscribe()

        XCTAssertEqual(tester.value.phase, .running)

        subject.send(completion: .failure(URLError(.badURL)))

        XCTAssertEqual(tester.value.phase.error, URLError(.badURL))
    }

    func testDispose() {
        var isSubscribed = false
        let subject = PassthroughSubject<Int, Never>()
        let tester = HookTester {
            usePublisherSubscribe {
                subject.handleEvents(receiveSubscription: { _ in
                    isSubscribed = true
                })
            }
        }

        XCTAssertEqual(tester.value.phase, .pending)

        tester.dispose()
        subject.send(1)

        XCTAssertEqual(tester.value.phase, .pending)
        XCTAssertFalse(isSubscribed)

        tester.value.subscribe()
        subject.send(2)

        XCTAssertEqual(tester.value.phase, .pending)
        XCTAssertFalse(isSubscribed)
    }
}
