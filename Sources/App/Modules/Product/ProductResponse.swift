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
	var consoleID: Int
	
	init(id: Int, name: String, consoleID: Int) {
		self.id = id
		self.name = name
		self.consoleID = consoleID
	}
}

extension ProductResponse {
	static func make(json: JSON) -> ProductResponse? {
		
		guard let id = json["id"] as? Int, let name = json["name"] as? String else {
			return nil
		}
		
		return ProductResponse(id: id, name: name, consoleID: 1)
	}
}

struct ProductAuthResponse: Content {
	
	var id: Int
	var name: String
	var consoleID: Int
	var isFavorite: Bool
	var isPurchased: Bool
	
	init(id: Int, name: String, consoleID: Int, isFavorite: Bool = true, isPurchased: Bool = true) {
		self.id = id
		self.name = name
		self.consoleID = consoleID
		self.isFavorite = isFavorite
		self.isPurchased = isPurchased
	}
}

extension ProductAuthResponse {
	static func make(json: JSON) -> ProductAuthResponse? {
		
		guard let id = json["id"] as? Int, let name = json["name"] as? String else {
			return nil
		}
		
		return ProductAuthResponse(id: id, name: name, consoleID: 1)
	}
}
