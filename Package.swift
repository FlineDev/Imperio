//
//  Package.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.02.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Imperio",
    dependencies: [
        .package(url: "https://github.com/ReactiveKit/Bond.git", .upToNextMajor(from: "6.5.0"))
    ]
)
