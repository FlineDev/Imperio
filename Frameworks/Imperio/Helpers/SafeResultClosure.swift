// Created by Cihat Gündüz on 18.10.18.

import Foundation

/// Wrapper for safe object callbacks. Use this as an alternative to `[weak self]` or `[unowned self]` references.
public struct SafeResultClosure<ResultType> {
    private var closure: (ResultType) -> Void

    /// Creates a new safe result closure using a weak reference automatically.
    ///
    /// In typical usage, you will call this like so:
    /// ```
    /// SafeResultClosure<String>(weak: self) { (self, resultString) in
    ///     self.someLabel.text = resultString
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - weak: The object to reference weakly automatically – typically `self` wil be passed here.
    ///   - closure: The closure to be called if the weak reference is not nil, giving you a strong reference to it and the result.
    public init<WeakObject: AnyObject>(weak object: WeakObject, closure: @escaping (WeakObject, ResultType) -> Void) {
        let weakClosure: (ResultType) -> Void = { [weak object] result in
            guard let object = object else { return }
            closure(object, result)
        }

        self.closure = weakClosure
    }

    /// Call this when the result is available.
    ///
    /// - Parameter result: The result to be passed into the closure.
    public func reportResult(result: ResultType) {
        closure(result)
    }
}
