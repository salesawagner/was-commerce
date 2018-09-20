//
//  AuthController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor
import FluentSQLite

final class AuthController: RouteCollection {

	func boot(router: Router) throws {

		let group = router.grouped("auth")

		// Public
		
		group.post("login", use: login)
		
		// Auth
		
		let tokenAuthGroup = self.getTokenAuthGroup(router: group)
		tokenAuthGroup.get("logout", use: logout)
	}

	// MARK: - Public

	func login(_ req: Request) throws -> Future<UserToken> {

		let login = try req.content.decode(LoginRequest.self).flatMap { login -> Future<Login> in
			let login = try Login.login(username: login.username, password: login.password)
			return login.persist(req)
		}

		let token = login.flatMap { login -> Future<UserToken> in
			let token = try UserToken.create(userID: login.requireID())
			return token.save(on: req)
		}

		return token
	}

	// MARK: - Auth

	func logout(_ req: Request) throws -> Future<HTTPStatus> {

		guard let userLocal = try Login.authenticated(req) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		let userToken = UserToken.query(on: req).filter(\.userID == userLocal.id)

		try req.unauthenticate(Login.self)
		return userToken.delete().transform(to: .ok)
	}
}
