//
//  AuthController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor
import Authentication
import FluentSQLite
import Crypto

final class User: NSObject {

	var id: Int
	var name: String
	var email: String
	var favoriteProducts: [Product] = []

	init(id: Int, name: String, email: String) {
		self.id = id
		self.name = name
		self.email = email
	}
	
	convenience init?(json: JSON) {
		guard let id = json["id"] as? Int, let name = json["name"] as? String, let email = json["email"] as? String else {
			return nil
		}
		self.init(id: id, name: name, email: email)
	}
}

// MARK: - Microservice connection

extension User {

	class func create(request: CreateUserRequest) throws -> User {

		guard request.password == request.verifyPassword else {
			throw Abort(.badRequest, reason: "Password and verification must match.")
		}

		let json = UserMicroService.create(parameters: request.toParameters())
		guard let user = User(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return user
	}
	
	class func update(userID: Int, request: UpdateUserRequest) throws -> User {

		let json = UserMicroService.update(userID: userID, parameters: request.toParameters())
		guard let user = User(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return user
	}
	
	class func delete(userID: Int) throws {
		let json = UserMicroService.delete(userID: userID)
		guard let success = json["success"] as? Bool, success else {
			throw Abort(.notAcceptable, reason: "User can not be deleted.")
		}
	}
	
	class func me(userID: Int) throws -> User {

		let json = UserMicroService.me(userID: userID)
		guard let user = User(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return user
	}
	
	class func favoriteCreate(userID: Int, request: FavoriteProductRequest) throws -> Product {
		let json = UserMicroService.favoriteCreate(userID: userID, productID: request.id)

		guard let product = Product(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return product
	}
	
	class func favoriteList(userID: Int) throws -> [Product] {
		let json = UserMicroService.favoriteList(userID: userID)
		guard let jsonList = json["list"] as? [JSON] else {
			throw Abort(.badRequest, reason: "Parse error.")
		}
		
		var list: [Product] = []
		for productJson in jsonList {
			if let product = Product(json: productJson) {
				list.append(product)
			}
		}
		
		return list
	}
}
