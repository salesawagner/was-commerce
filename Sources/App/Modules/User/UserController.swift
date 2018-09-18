//
//  UserController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor
import FluentSQLite

final class UserController: RouteCollection {

	func boot(router: Router) throws {

		let group = router.grouped("user")

		// Public

		group.post("create", use: create)

		// Private

		let tokenAuthGroup = self.getTokenAuthGroup(router: group)
		tokenAuthGroup.get("me", use: update)
		tokenAuthGroup.put("update", use: update)
		tokenAuthGroup.delete("delete", use: delete)
		
		let favoriteGroup = tokenAuthGroup.grouped("favorite")
		favoriteGroup.post("create", use: favoriteCreate)
		favoriteGroup.delete("delete", use: favoriteDelete)
		favoriteGroup.get("list", use: favoriteList)
	}

	// MARK: - PUBLIC

	func create(_ req: Request) throws -> Future<Response> {

		let userResponse = try req.content.decode(CreateUserRequest.self).flatMap { userRequest -> Future<Response> in

			guard userRequest.password == userRequest.verifyPassword else {
				throw Abort(.badRequest, reason: "Password and verification must match.")
			}

			let json = UserMicroService.create(parameters: userRequest.toParameters())
			guard let userResponse = UserResponse.make(json: json) else {
				throw Abort(.badRequest, reason: "Parse error.")
			}

			return try userResponse.encode(for: req)
		}

		return userResponse
	}

	// MARK: - AUTH
	
	// MARK: - User

	func me(_ req: Request) throws -> Future<Response> {
		
		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let json = UserMicroService.me(userID: try userLocal.requireID())
		guard let userResponse = UserResponse.make(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return try userResponse.encode(for: req)
	}

	func update(_ req: Request) throws -> Future<Response> {

		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		let userResponse = try req.content.decode(UpdateUserRequest.self).flatMap { userRequest -> Future<Response> in

			let userID = try userLocal.requireID()
			let json = UserMicroService.update(userID: userID, parameters: userRequest.toParameters())
			guard let userResponse = UserResponse.make(json: json) else {
				throw Abort(.badRequest, reason: "Parse error.")
			}

			userLocal.name = userRequest.name
			userLocal.email = userRequest.email
			let _ = userLocal.update(on: req)

			return try userResponse.encode(for: req)
		}

		return userResponse
	}
	
	func delete(_ req: Request) throws -> Future<HTTPStatus> {

		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		let json = UserMicroService.delete(userID: try userLocal.requireID())
		guard let success = json["success"] as? Bool, success else {
			throw Abort(.notAcceptable, reason: "User can not be deleted.")
		}

		let authController = AuthController()
		return try authController.logout(req)
	}
	
	// MARK: - Favorite
	
	func favoriteCreate(_ req: Request) throws -> Future<Response> {
		
		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let response = try req.content.decode(FavoriteProductRequest.self).flatMap { product -> Future<Response> in
			
			let json = UserMicroService.favoriteCreate(userID: try userLocal.requireID(), productID: product.id)
			guard let productResponse = ProductResponse.make(json: json) else {
				throw Abort(.badRequest, reason: "Parse error.")
			}
			
			return try productResponse.encode(for: req)
		}
		
		return response
	}
	
	func favoriteDelete(_ req: Request) throws -> Future<HTTPStatus> {
		
		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let response = try req.content.decode(FavoriteProductRequest.self).flatMap { product -> Future<Response> in
			
			let json = UserMicroService.favoriteDelete(userID: try userLocal.requireID(), productID: product.id)
			guard let success = json["success"] as? Bool, success else {
				throw Abort(.badRequest, reason: "Parse error.")
			}

			return try HTTPStatus.ok.encode(for: req)
		}
		
		return response.transform(to: .ok)
	}
	
	func favoriteList(_ req: Request) throws -> Future<Response> {
		
		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let json = UserMicroService.favoriteList(userID: try userLocal.requireID())
		guard let response = FavoriteListResponse.make(json: json) else {
			throw Abort(.badRequest, reason: "Parse error.")
		}

		return try response.encode(for: req)
	}

}
