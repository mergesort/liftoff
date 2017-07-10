import Foundation

extension DispatchQueue {
    
    /// This function calls `DispatchQueue.asyncAfter` with a certain `DispatchTimeInterval` after now.
    ///
    /// - Parameters:
    ///   - interval: The `DispatchTimeInterval` to add onto the current `DispatchTime`.
    ///   - work: An block to invoke after the interval has elapsed.
    func asyncAfterNow(interval: DispatchTimeInterval, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: DispatchTime.now() + interval, execute: work)
    }
}
