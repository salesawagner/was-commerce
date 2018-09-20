//
//  Product.swift
//  App
//
//  Created by Wagner Sales on 19/09/18.
//

import Vapor

final class Product {

	var id: Int
	var name: String
	var console: Console
	var recomendations: [Product] = []

	var isFavorite: Bool
	var isPurchased: Bool

	init(id: Int, name: String, console: Console, isFavorite: Bool, isPurchased: Bool, recomendations: [Product] = []) {
		self.id = id
		self.name = name
		self.console = console
		self.isFavorite = isFavorite
		self.isPurchased = isPurchased
		self.recomendations = recomendations
	}

	convenience init?(json: JSON) {

		guard
			let id = json["id"] as? Int,
			let name = json["name"] as? String,
			let consoleInfo = (try? Console.getInfo(productJson: json)),
			let console = consoleInfo  else {
			return nil
		}

		let isFavorite: Bool? = json["isFavorite"] as? Bool
		let isPurchased: Bool? = json["isPurchased"] as? Bool

		var recomendations: [Product] = []
		if let recomendationJsonList = json["recomendations"] as? [JSON] {
			for recomendationJson in recomendationJsonList {
				if let product = Product(json: recomendationJson) {
					recomendations.append(product)
				}
			}
		}

		self.init(id: id,
				  name: name,
				  console: console,
				  isFavorite: isFavorite ?? false,
				  isPurchased: isPurchased ?? false,
				  recomendations: recomendations)
	}
}

extension Product: Parameter {
	typealias ResolvedParameter = Int
	static func resolveParameter(_ parameter: String, on container: Container) throws -> Int {
		return Int(parameter) ?? 0
	}
}

// MARK: - Microservice connection

extension Product {
	
	class func detail(userID: Int?, productID: Int) throws -> Product {

		let json = ProductMicroService.detail(userID: userID, productID: productID)
		
		guard let product = Product(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}
		
		return product
	}
	
	class func list(userID: Int?, parameters: [String: Any]) -> [Product] {

		let json = ProductMicroService.list(userID: userID, parameters: parameters)
		guard let jsonList = json["list"] as? [JSON] else {
			return []
		}

		var list: [Product] = []
		for productJson in jsonList {
			if let product = Product(json: productJson) {
				list.append(product)
			}
		}

		return list
	}
	
	class func favoriteList(userID: Int) -> [Product] {
		
		let json = UserMicroService.favoriteList(userID: userID)
		guard let jsonList = json["list"] as? [JSON] else {
			return []
		}
		
		var list: [Product] = []
		for productJson in jsonList {
			if let product = Product(json: productJson) {
				list.append(product)
			}
		}
		
		return list
	}
}
