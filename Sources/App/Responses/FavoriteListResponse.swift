//
//  FavoriteListResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de response da lista de favoritos do usuário
struct FavoriteListResponse: Content {
	
	/// lista de produtos favoritos
	var list: [FavoriteProductResponse]
	
	init(list: [Product]) {
		self.list = list.map { product -> FavoriteProductResponse in
			FavoriteProductResponse(product: product)
		}
	}
}
