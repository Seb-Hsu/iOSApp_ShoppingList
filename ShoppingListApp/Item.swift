//
//  Item.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 25/3/2026.
//

import Foundation

public class Item {
    public var name: String
    public private(set) var price: Double
    public private(set) var category: String
    public var qty: Int
    public var imageName: String

    public init() {
        self.name = ""
        self.price = 0.0
        self.category = ""
        self.qty = 0
        self.imageName = ""
    }

    public init(name: String, price: Double, category: String, qty: Int, imageName: String) {
        self.name = name
        self.price = price
        self.category = category
        self.qty = qty
        self.imageName = imageName
    }

    public func toString() -> String {
        return "$" + String(format: "%.2f", price) + " Category: " + category
            + " Qty: " + String(format: "%d", qty)
    }
}
