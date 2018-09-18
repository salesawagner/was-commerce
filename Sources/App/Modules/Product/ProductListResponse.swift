//
//  ProductListResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct ProductListResponse: Content {
	var list: [ProductResponse]
}

extension ProductListResponse {
	static func make(json: JSON) -> ProductListResponse? {
		guard let products = json["list"] as? [[String: Any]] else {
			return nil
		}
		
		var list: [ProductResponse] = []
		for product in products {
			if let product = ProductResponse.make(json: product) {
				list.append(product)
			}
		}
		
		return ProductListResponse(list: list)
	}
}

struct ProductListAuthResponse: Content {
	var list: [ProductAuthResponse]
}

extension ProductListAuthResponse {
	static func make(json: JSON) -> ProductListAuthResponse? {
		guard let products = json["list"] as? [[String: Any]] else {
			return nil
		}
		
		var list: [ProductAuthResponse] = []
		for product in products {
			if let product = ProductAuthResponse.make(json: product) {
				list.append(product)
			}
		}
		
		return ProductListAuthResponse(list: list)
	}
}
