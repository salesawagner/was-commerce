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
