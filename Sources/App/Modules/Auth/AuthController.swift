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

		// Public
		
		group.post("login", use: login)
		group.get("list", use: list) // FIXME: For debug, remove!
		
		// Auth
		
		let tokenAuthGroup = self.getTokenAuthGroup(router: group)
		tokenAuthGroup.get("logout", use: logout)
	}

	// MARK: - Public

	func login(_ req: Request) throws -> Future<UserToken> {

		let user = try req.content.decode(LoginRequest.self).flatMap { login -> Future<User> in

			let hash = try BCrypt.hash(login.password)
			let json = UserMicroService.login(username: login.username, password: login.password)

			guard let user = User.make(json: json, passwordHash: hash) else {
				throw Abort(.badRequest, reason: "Parse error.")
			}

			return User.query(on: req).filter(\.email == user.email).first().flatMap({ optionalUser -> Future<User> in
				guard let localUser = optionalUser else {
					return user.save(on: req)
				}

				return localUser.update(on: req)
			})

		}

		let token = user.flatMap { user -> Future<UserToken> in
			let token = try UserToken.create(userID: user.requireID())
			return token.save(on: req)
		}

		return token
	}

	// MARK: - Auth

	func logout(_ req: Request) throws -> Future<HTTPStatus> {
		
		guard let userLocal = try req.authenticated(User.self) else {
			throw Abort(.unauthorized, reason: "User has not been authorized.")
		}

		let userToken = try UserToken.query(on: req).filter(\.userID == userLocal.requireID())

		try req.unauthenticate(User.self)
		return userToken.delete().transform(to: .ok)
	}

	func list(_ req: Request) throws -> Future<[UserToken]> {
		return UserToken.query(on: req).all()
	}
}
