import Foundation

extension DispatchTime {

    static func afterNow(interval: DispatchTimeInterval) -> DispatchTime {
        return DispatchTime.now() + interval
    }
}

extension DispatchQueue {

    func asyncAfterNow(interval: DispatchTimeInterval, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime.afterNow(interval: interval), execute: work)
    }
}
