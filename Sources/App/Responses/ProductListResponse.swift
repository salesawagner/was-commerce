//
//  ProductListResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de response da lista de produtos
struct ProductListResponse: Content {
	
	/// lista de produtos
	var list: [ProductResponse]
	
	init(products: [Product], auth: Bool = false) {
		var list: [ProductResponse] = []
		for product in products {
			list.append(ProductResponse(product: product, auth: auth))
		}
		
		self.list = list
	}
}
