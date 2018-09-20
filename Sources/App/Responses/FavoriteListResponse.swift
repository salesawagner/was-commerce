//
//  FavoriteListResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct FavoriteListResponse: Content {
	var list: [FavoriteProductResponse]
	
	init(list: [Product]) {
		self.list = list.map { product -> FavoriteProductResponse in
			FavoriteProductResponse(product: product)
		}
	}
}
