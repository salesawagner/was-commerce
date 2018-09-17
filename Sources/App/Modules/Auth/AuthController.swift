//
//  AuthController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Crypto
import Vapor
import FluentSQLite

final class AuthController: RouteCollection {

	func boot(router: Router) throws {
		let group = router.grouped("auth")
		try self.get(group: group)
		try self.post(group: group)
	}

	func get(group: Router) throws {
		let bearer = group.grouped(User.tokenAuthMiddleware())
		bearer.get("logout", use: logout)
	}

	func post(group: Router) throws {
		let basic = group.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
		basic.post("login", use: login)
	}

	func login(_ req: Request) throws -> Future<UserToken> {

		let user = try req.requireAuthenticated(User.self)
		let token = try UserToken.create(userID: user.requireID())

		return token.save(on: req)
	}

	func logout(_ req: Request) throws -> Future<HTTPStatus> {

		let user = try req.requireAuthenticated(User.self)
		let userToken = try UserToken.query(on: req).filter(\.userID == user.requireID())

		try req.unauthenticate(User.self)
		return userToken.delete().transform(to: .ok)
	}
}
