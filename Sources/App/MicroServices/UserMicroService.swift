//
//  UserMicroService.swift
//  App
//
//  Created by Wagner Sales on 17/09/18.
//

import Foundation

class UserMicroService: NSObject {
	
	// MAK: - Auth
	
	class func login(username: String, password: String) -> JSON {
		return Mock.JSONSuccess
	}
	
	// MAK: - CRUD

	class func create(parameters: [String: Any]) -> JSON {
		return Mock.JSONUser
	}
	
	class func update(userID: Int, parameters: [String: Any]) -> JSON {
		return Mock.JSONUser
	}
	
	class func me(userID: Int) -> JSON {
		return Mock.JSONUser
	}
	
	class func delete(userID: Int) -> JSON {
		return Mock.JSONSuccess
	}
	
	// MAK: - Favorite
	
	class func favoriteCreate(userID: Int, productID: Int) -> JSON {
		return Mock.JSONProduct
	}
	
	class func favoriteDelete(userID: Int, productID: Int) -> JSON {
		return Mock.JSONSuccess
	}
	
	class func favoriteList(userID: Int) -> JSON {
		return Mock.JSONProductList
	}
}
