import Foundation

extension DispatchTime {

    /// This function is shorthand for returning the current `DispatchTime` plus a certain interval,
    /// useful for calculating a certain time interval after the present time.
    ///
    /// - Parameter interval: The `DispatchTimeInterval` to add onto the current `DispatchTime`.
    /// - Returns: Returns a dispatch time by adding the current `DispatchTime` with the passed in interval.
    static func afterNow(interval: DispatchTimeInterval) -> DispatchTime {
        return DispatchTime.now() + interval
    }
}

extension DispatchQueue {

    /// This function calls `DispatchQueue.asyncAfter` with a certain `DispatchTimeInterval` after now.
    ///
    /// - Parameters:
    ///   - interval: The `DispatchTimeInterval` to add onto the current `DispatchTime`.
    ///   - work: An block to invoke after the interval has elapsed.
    func asyncAfterNow(interval: DispatchTimeInterval, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime.afterNow(interval: interval), execute: work)
    }
}
