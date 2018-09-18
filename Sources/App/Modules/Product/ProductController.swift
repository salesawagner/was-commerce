//
//  ProductController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor
import FluentSQLite

final class ProductController: RouteCollection {

	func boot(router: Router) throws {
		let group = router.grouped("product")
		let tokenAuthGroup = group.grouped(User.tokenAuthMiddleware()) 
		tokenAuthGroup.get("list", use: list)
	}
	
	func list(_ req: Request) throws -> Future<Response> {
		
		let userLocal = try req.authenticated(User.self)
		
		let json = ProductMicroService.list(userID: try userLocal?.requireID(), parameters: [:])
		
		var response: Future<Response>
		if userLocal == nil {
			guard let list = ProductListResponse.make(json: json) else {
				throw Abort(.badRequest, reason: "Parse error.")
			}
			response = try list.encode(for: req)
		} else {
			guard let list = ProductListAuthResponse.make(json: json) else {
				throw Abort(.badRequest, reason: "Parse error.")
			}
			response = try list.encode(for: req)
		}
		
		return response
	}

}
