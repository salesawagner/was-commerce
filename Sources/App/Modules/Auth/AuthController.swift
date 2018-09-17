//
//  AuthController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Crypto
import Vapor

final class AuthController {

	func boot(router: Router) throws {
		let group = router.grouped("auth")
		try self.post(group: group)
	}

	func post(group: Router) throws {
		group.post("login", use: login)
		group.post("logout", use: logout)
	}

	func login(_ req: Request) throws -> Future<UserToken> {
		
		try req.print()

		// get user auth'd by basic auth middleware
		let user = try req.requireAuthenticated(User.self)
		
		// create new token for this user
		let token = try UserToken.create(userID: user.requireID())
		
		// save and return token
		return token.save(on: req)
	}
	
	func logout(_ req: Request) throws -> Future<UserToken> {
		
		// TODO: - Fazer logout
		
		// get user auth'd by basic auth middleware
		let user = try req.requireAuthenticated(User.self)
		
		// create new token for this user
		let token = try UserToken.create(userID: user.requireID())
		
		// save and return token
		return token.save(on: req)
	}

}
