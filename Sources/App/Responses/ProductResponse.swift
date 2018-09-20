//
//  ProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de response de produto
struct ProductResponse: Content {
	
	/// ID do produto
	var id: Int
	
	/// Nome do produto
	var name: String
	
	/// ID do console que o produto pertence
	var consoleID: Int
	
	/// Bool para identificar se o usuário já favoritou o produto
	var isFavorite: Bool?
	
	/// Bool para identificar se o usuário já comprou o produto
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
