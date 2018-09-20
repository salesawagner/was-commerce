//
//  UserController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor

/// Controladora para as rota de produto
final class UserController: RouteCollection {

	func boot(router: Router) throws {

		let group = router.grouped("user")

		// Public

		group.post("create", use: create)

		// Private

		let tokenAuthGroup = self.getTokenAuthGroup(router: group)
		tokenAuthGroup.get("me", use: me)
		tokenAuthGroup.put("update", use: update)
		tokenAuthGroup.delete("delete", use: delete)
		
		let favoriteGroup = tokenAuthGroup.grouped("favorite")
		favoriteGroup.post("create", use: favoriteCreate)
		favoriteGroup.delete("delete", use: favoriteDelete)
		favoriteGroup.get("list", use: favoriteList)
	}

	// MARK: - PUBLIC

	func create(_ req: Request) throws -> Future<Response> {

		let response = try req.content.decode(CreateUserRequest.self).flatMap { request -> Future<Response> in
			let user = try User.create(request: request)
			let response = UserResponse(user: user)
			return try response.encode(for: req)
		}

		return response
	}

	// MARK: - AUTH
	
	// MARK: - User

	func me(_ req: Request) throws -> Future<Response> {

		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		let user = try User.me(userID: userLocal.id)
		let response = UserResponse(user: user)

		return try response.encode(for: req)
	}

	func update(_ req: Request) throws -> Future<Response> {

		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		let response = try req.content.decode(UpdateUserRequest.self).flatMap { request -> Future<Response> in

			let userID = userLocal.id
			let user = try User.update(userID: userID, request: request)
			let response = UserResponse(user: user)

			return try response.encode(for: req)
		}

		return response
	}
	
	func delete(_ req: Request) throws -> Future<HTTPStatus> {

		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		try User.delete(userID: userLocal.id)

		let authController = AuthController()
		return try authController.logout(req)
	}
	
	// MARK: - Favorite
	
	func favoriteCreate(_ req: Request) throws -> Future<Response> {
		
		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let response = try req.content.decode(FavoriteProductRequest.self).flatMap { request -> Future<Response> in
			let product = try User.favoriteCreate(userID: userLocal.id, request: request)
			let response = FavoriteProductResponse(product: product)
			return try response.encode(for: req)
		}
		
		return response
	}
	
	func favoriteDelete(_ req: Request) throws -> Future<HTTPStatus> {
		
		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let response = try req.content.decode(FavoriteProductRequest.self).flatMap { product -> Future<Response> in
			
			let json = UserMicroService.favoriteDelete(userID: userLocal.id, productID: product.productID)
			guard let success = json["success"] as? Bool, success else {
				throw Abort(.badRequest, reason: "Parse error.")
			}

			return try HTTPStatus.ok.encode(for: req)
		}
		
		return response.transform(to: .ok)
	}
	
	func favoriteList(_ req: Request) throws -> Future<Response> {
		
		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}
		
		let list = try User.favoriteList(userID: userLocal.id)

		let response = FavoriteListResponse(list: list)
		return try response.encode(for: req)
	}

}
