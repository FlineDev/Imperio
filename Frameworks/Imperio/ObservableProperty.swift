//
//  InitialFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 17.10.18.
//  Copyright © 2018 Flinesoft. All rights reserved.
//

import Foundation

/// A binding wrapper to track changes on constant properties.
public class ObservableProperty<ValueType> {
    // MARK: - Stored Instance Properties
    private var didSetClosures: [(ValueType) -> Void] = []

    /// The value encapsulated within the observable property wrapper.
    public private(set) var value: ValueType {
        didSet {
            didSetClosures.forEach { $0(value) }
        }
    }

    // MARK: - Initializers
    /// Creates a new observable property with the given initial value.
    public init(_ value: ValueType) {
        self.value = value
    }

    // MARK: - Instance Methods
    /// Will be called after the wrapped value is changed.
    /// `$0` is the passed parameter (usually `self`), `$1` is the new value.
    public func didSet<WeakObject: AnyObject>(weak object: WeakObject, _ closure: @escaping (WeakObject, ValueType) -> Void) {
        let weakClosure: (ValueType) -> Void = { [weak object] value in
            guard let object = object else { return }
            closure(object, value)
        }

        didSetClosures.append(weakClosure)
        weakClosure(value)
    }

    /// Use to change the value wrapped as a variable.
    public func set(_ newValue: ValueType) {
        value = newValue
    }
}
