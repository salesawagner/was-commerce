//
//  ProductListResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct ProductListResponse: Content {
	var list: [ProductResponse]
	
	init(products: [Product], auth: Bool = false) {
		var list: [ProductResponse] = []
		for product in products {
			list.append(ProductResponse(product: product, auth: auth))
		}
		
		self.list = list
	}
}
