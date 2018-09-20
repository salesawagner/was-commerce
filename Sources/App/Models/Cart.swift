//
//  Cart.swift
//  App
//
//  Created by Wagner Sales on 20/09/18.
//

import Vapor


final class Cart {

	var id: Int
	var products: [Product] = []

	init(id: Int, products: [Product]) {
		self.id = id
		self.products = products
	}

	convenience init?(json: JSON) {
		guard let id = json["id"] as? Int, let productsList = json["products"] as? [JSON] else {
			return nil
		}

		let products = Product.listProducts(from: productsList)
		self.init(id: id, products: products)
	}
}

// MARK: - Microservice connection

extension Cart {
	class func create(userID: Int?, request: CreateCartRequest) throws -> Product {

		let json = BillingMicroService.create(userID: userID, productID: request.productID)
		guard let product = Product(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return product
	}
	
	class func list(userID: Int?) throws -> [Product] {
		
		let json = BillingMicroService.list(userID: userID)
		guard let jsonList = json["list"] as? [JSON] else {
			return []
		}
		
		let list: [Product] = Product.listProducts(from: jsonList)
		return list
	}
}
