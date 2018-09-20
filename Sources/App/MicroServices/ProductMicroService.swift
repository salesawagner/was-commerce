//
//  ProductMicroService.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Foundation

class ProductMicroService: NSObject {
	class func console(consoleID: Int) -> JSON {
		return Mock.JSONConsole
	}
	class func list(userID: Int? = nil, parameters: [String: Any]) -> JSON {
		return Mock.JSONProductList
	}
}
