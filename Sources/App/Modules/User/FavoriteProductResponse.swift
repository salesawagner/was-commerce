//
//  FavoriteProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct FavoriteProductResponse: Content {
	var id: Int
	var name: String
	let consoleID: Int = 1
}

extension FavoriteProductResponse {
	static func make(json: JSON) -> FavoriteProductResponse? {
		
		guard let id = json["id"] as? Int, let name = json["name"] as? String else {
			return nil
		}
		
		return FavoriteProductResponse(id: id, name: name)
	}
}
