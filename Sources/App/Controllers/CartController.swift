//
//  CartController.swift
//  App
//
//  Created by Wagner Sales on 20/09/18.
//

import Vapor

/// Controladora para as rotas de carrinho
final class CartController: RouteCollection {
	
	func boot(router: Router) throws {
		let group = router.grouped("cart")
		let tokenAuthGroup = group.grouped(Login.tokenAuthMiddleware())
		tokenAuthGroup.post("create", use: create)
		tokenAuthGroup.get("list", use: list)
	}
	
	func create(_ req: Request) throws -> Future<Response> {

		let userLocal = try Login.authenticated(req)

		let response = try req.content.decode(CreateCartRequest.self).flatMap { request -> Future<Response> in

			let userID = userLocal?.id
			let product = try Cart.create(userID: userID, request: request)
			let response = ProductResponse(product: product, auth: userID != nil)

			return try response.encode(for: req)
		}

		return response
	}
	
	func list(_ req: Request) throws -> Future<Response> {

		let userLocal = try Login.authenticated(req)

		let userID = userLocal?.id

		let list = try Cart.list(userID: userID)
		let response = ProductListResponse(products: list)

		return try response.encode(for: req)
	}
}
