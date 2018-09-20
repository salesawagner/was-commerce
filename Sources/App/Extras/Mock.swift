//
//  Mock.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Foundation

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
		var json: JSON = [:]
		json["id"] = 1
		json["name"] = "Fifa 19"
		json["consoleID"] = 1
		return json
	}
	static var JSONProductList: [String: Any] {
		var fifa: JSON = [:]
		fifa["id"] = 1
		fifa["name"] = "Fifa 19"
		fifa["consoleID"] = 1
		
		var f1: JSON = [:]
		f1["id"] = 2
		f1["name"] = "F1 2018"
		f1["consoleID"] = 1
		
		var json: JSON = [:]
		json["list"] = [fifa, f1]
		
		return json
	}
	
	static var JSONConsole: [String: Any] {
		var json: JSON = [:]
		json["id"] = 1
		json["name"] = "PS4"
		return json
	}
}
