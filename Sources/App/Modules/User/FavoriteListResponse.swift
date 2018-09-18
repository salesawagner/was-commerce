//
//  FavoriteListResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct FavoriteListResponse: Content {
	var list: [FavoriteProductResponse]
}

extension FavoriteListResponse {
	static func make(json: JSON) -> FavoriteListResponse? {
		guard let products = json["list"] as? [[String: Any]] else {
			return nil
		}
		
		var list: [FavoriteProductResponse] = []
		for product in products {
			if let product = FavoriteProductResponse.make(json: product) {
				list.append(product)
			}
		}
		
		return FavoriteListResponse(list: list)
	}
}
