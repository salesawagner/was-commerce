//
//  FavoriteProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de response de produto favorito
struct FavoriteProductResponse: Content {

	/// ID do produto
	let id: Int
	
	/// Nome do produto
	let name: String
	
	/// ID do console que o produto pertence
	let consoleID: Int

	init(product: Product) {
		self.id = product.id
		self.name = product.name
		self.consoleID = product.console.id
	}
}
