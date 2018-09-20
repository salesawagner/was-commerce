//
//  FavoriteProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// balbalb abla alba lab alb
struct FavoriteProductResponse: Content {

	
	/// adsasdads
	let id: Int
	
	/// asdasdasd
	let name: String
	
	/// adsdsadads
	let consoleID: Int

	/// asdasdasd
	///
	/// - Parameter product: asdasdasds
	init(product: Product) {
		self.id = product.id
		self.name = product.name
		self.consoleID = product.console.id
	}
}
