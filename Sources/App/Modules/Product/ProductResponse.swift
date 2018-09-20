//
//  ProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct ProductResponse: Content {
	
	var id: Int
	var name: String
	var consoleID: Int
	var isFavorite: Bool?
	var isPurchased: Bool?

	init(product: Product, auth: Bool = false) {

		self.id = product.id
		self.name = product.name
		self.consoleID = product.console.id
		
		if auth {
			self.isFavorite = product.isFavorite
			self.isPurchased = product.isPurchased
		}
	}
}

struct ProductDetailResponse: Content {
	
	var id: Int
	var name: String
	var consoleID: Int
	var isFavorite: Bool?
	var isPurchased: Bool?
	var recomendations: [ProductResponse]?
	
	init(product: Product, auth: Bool = false) {
		
		self.id = product.id
		self.name = product.name
		self.consoleID = product.console.id
		
		if auth {
			self.isFavorite = product.isFavorite
			self.isPurchased = product.isPurchased
		}
		
		if product.recomendations.count > 0 {
			var recomendations: [ProductResponse] = []
			for recomendation in product.recomendations {
				let productResponse = ProductResponse(product: recomendation)
				recomendations.append(productResponse)
			}
			self.recomendations = recomendations
		}
	}
}
