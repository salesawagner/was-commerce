//
//  ProductController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor

/// Controladora para as rota de produto
final class ProductController: RouteCollection {

	func boot(router: Router) throws {
		let group = router.grouped("product")
		let tokenAuthGroup = group.grouped(Login.tokenAuthMiddleware())
		tokenAuthGroup.get("detail", Product.parameter, use: detail)
		tokenAuthGroup.get("list", use: list)
	}
	
	func detail(_ req: Request) throws -> Future<Response> {

		let productID = try req.parameters.next(Product.self)
		let user = try Login.authenticated(req)
		let product = try Product.detail(userID: user?.id, productID: productID)

		let response = ProductDetailResponse(product: product, auth: user != nil)
		return try response.encode(for: req)
	}
	
	func list(_ req: Request) throws -> Future<Response> {
		
		let user = try Login.authenticated(req)
		let list = Product.list(userID: user?.id, parameters: [:])
		
		let response = ProductListResponse(products: list, auth: user != nil)
		return try response.encode(for: req)
	}

}
