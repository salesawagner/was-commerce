//
//  FavoriteProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct FavoriteProductResponse: Content {

	let id: Int
	let name: String
	let consoleID: Int

	init(product: Product) {
		self.id = product.id
		self.name = product.name
		self.consoleID = product.console.id
	}
}
