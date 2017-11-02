//
//  Flowable.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// A protocol to be implemented in the view layer to delegate screen flow user interactions.
public protocol Flowable {
    associatedtype FlowDelegate

    var flowDelegate: FlowDelegate? { get set }
}
