//
//  ProductResponse.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct ProductResponse: Content {
	var id: Int
	var name: String
}

extension ProductResponse {
	static func make(json: JSON) -> ProductResponse? {
		
		guard let id = json["id"] as? Int, let name = json["name"] as? String else {
			return nil
		}
		
		return ProductResponse(id: id, name: name)
	}
}
