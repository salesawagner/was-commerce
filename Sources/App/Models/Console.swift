//
//  Console.swift
//  App
//
//  Created by Wagner Sales on 19/09/18.
//

import Vapor

final class Console: Encodable, Decodable {
	
	var id: Int
	var name: String
	
	init(id: Int, name: String) {
		self.id = id
		self.name = name
	}
	
	convenience init?(json: JSON) {
		guard let id = json["id"] as? Int, let name = json["name"] as? String else {
			return nil
		}
		self.init(id: id, name: name)
	}
}

// MARK: - Microservice connection

extension Console {
	class func getInfo(productJson: JSON) throws -> Console? {
		guard let id = productJson["consoleID"] as? Int else {
			throw Abort(.badRequest, reason: "Parse error.")
		}
		
		let json = ProductMicroService.console(consoleID: id)
		return Console(json: json)
	}
}
