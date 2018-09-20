//
//  Login.swift
//  App
//
//  Created by Wagner Sales on 19/09/18.
//

import Vapor
import Authentication
import FluentSQLite
import Crypto

final class Login: SQLiteModel, Content, Parameter {
	
	var id: Int?
	var email: String
	var passwordHash: String
	
	init(id: Int? = nil, email: String, password: String) {
		self.id = id
		self.email = email
		self.passwordHash = password
	}

	func persist(_ req: Request) -> Future<Login> {
		return Login.query(on: req).filter(\.email == self.email).first().flatMap({ optionalLogin -> Future<Login> in
			guard let localLogin = optionalLogin else {
				return self.save(on: req)
			}
			
			return localLogin.update(on: req)
		})
	}
}

// MARK: - Microservice connection

extension Login {
	class func login(username: String, password: String) throws -> Login {
		let hash = try BCrypt.hash(password)
		let json = UserMicroService.login(username: username, password: hash)
		guard let success = json["success"] as? Bool, success else {
			throw Abort(.badRequest, reason: "User and Password verification failed.")
		}
		return Login(email: username, password: hash)
	}
	class func authenticated(_ req: Request) throws -> User? {
		guard let login = try req.authenticated(Login.self) else {
			return nil
		}
		let userID = try login.requireID()
		return try User.me(userID: userID)
	}
}

// MARK: - PasswordAuthenticatable

extension Login: PasswordAuthenticatable {
	
	static var usernameKey: WritableKeyPath<Login, String> {
		return \.email
	}
	
	static var passwordKey: WritableKeyPath<Login, String> {
		return \.passwordHash
	}
}

// MARK: - TokenAuthenticatable

extension Login: TokenAuthenticatable {
	typealias TokenType = UserToken
}

// MARK: - Migration

extension Login: Migration {
	static func prepare(on conn: SQLiteConnection) -> Future<Void> {
		return SQLiteDatabase.create(Login.self, on: conn) { builder in
			builder.field(for: \.id, isIdentifier: true)
			builder.field(for: \.email)
			builder.field(for: \.passwordHash)
			builder.unique(on: \.email)
		}
	}
}

