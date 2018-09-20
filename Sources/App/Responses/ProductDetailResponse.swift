//
//  ProductDetailResponse.swift
//  App
//
//  Created by Wagner Sales on 20/09/18.
//

import Vapor

/// Struct de response do produto detalhado
struct ProductDetailResponse: Content {
	
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
	
	/// Lista de produto recomendados com base no produto detalhado
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
