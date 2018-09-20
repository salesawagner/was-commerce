//
//  Product.swift
//  App
//
//  Created by Wagner Sales on 19/09/18.
//

import Vapor

final class Product: NSObject {

	var id: Int
	var name: String
	var console: Console
	
	init(id: Int, name: String, console: Console) {
		self.id = id
		self.name = name
		self.console = console
	}
	
	convenience init?(json: JSON) {

		guard
			let id = json["id"] as? Int,
			let name = json["name"] as? String,
			let consoleInfo = (try? Console.getInfo(productJson: json)),
			let console = consoleInfo  else {
			return nil
		}

		self.init(id: id, name: name, console: console)
	}
}
