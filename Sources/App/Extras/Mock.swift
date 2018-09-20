//
//  Mock.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Foundation

/// blablaba blablab alb alb alab lab alb alab 
struct Mock {
	static let JSONSuccess: [String: Bool] = ["success": true]
	static var JSONUser: [String: Any] {
		var json: JSON = [:]
		json["id"] = 1
		json["name"] = "Wagner Sales"
		json["email"] = "salesawagner@gmail.com"
		return json
	}
	static var JSONProduct: [String: Any] {
		
		var recomendations: [JSON] = []
		for i in 1...10 {
			var json: JSON = [:]
			json["id"] = i
			json["name"] = "Product \(i)"
			json["consoleID"] = 1
			recomendations.append(json)
		}
		
		var json: JSON = [:]
		json["id"] = 1
		json["name"] = "Product \(1)"
		json["consoleID"] = 1
		json["recomendations"] = recomendations
		
		return json
	}
	static var JSONProductList: [String: Any] {
		
		var list: [JSON] = []
		for i in 1...10 {
			var json: JSON = [:]
			json["id"] = i
			json["name"] = "Product \(i)"
			json["consoleID"] = 1
			list.append(json)
		}

		var json: JSON = [:]
		json["list"] = list
		
		return json
	}
	
	static var JSONConsole: [String: Any] {
		var json: JSON = [:]
		json["id"] = 1
		json["name"] = "PS4"
		return json
	}
}
