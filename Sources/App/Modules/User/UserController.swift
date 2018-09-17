import Crypto
import Vapor
import FluentSQLite

final class UserController: RouteCollection {
	
	func boot(router: Router) throws {
		let group = router.grouped("user")
		try self.get(group: group)
		try self.post(group: group)
	}
	
	func get(group: Router) throws {
		let bearer = group.grouped(User.tokenAuthMiddleware())
		bearer.get("list", use: list)
		bearer.get("me", use: me)
	}
	
	func post(group: Router) throws {
		group.post("create", use: create)
		group.post("update", use: update)
	}
	
	func create(_ req: Request) throws -> Future<UserResponse> {

		let user = try req.content.decode(CreateUserRequest.self).flatMap { user -> Future<User> in

			guard user.password == user.verifyPassword else {
				throw Abort(.badRequest, reason: "Password and verification must match.")
			}

			let hash = try BCrypt.hash(user.password)
			let user = User(id: nil, name: user.name, email: user.email, passwordHash: hash)

			return user.save(on: req)
		}

		let response = user.map { user in
			return try UserResponse(id: user.requireID(), name: user.name, email: user.email)
		}

		return response
	}
	
	func update(_ req: Request) throws -> Future<UserResponse> {

		let user = try req.requireAuthenticated(User.self)
		let update = try req.content.decode(CreateUserRequest.self).flatMap({ newUser -> Future<User> in
			user.name = newUser.name
			user.email = newUser.email
			return user.save(on: req)
		})

		let response = update.map { user in
			return try UserResponse(id: user.requireID(), name: user.name, email: user.email)
		}

		return response
	}
	
	func me(_ req: Request) throws -> Future<Response> {
		let user = try req.requireAuthenticated(User.self)
		return try user.toUserResponse().encode(for: req)
	}

	func list(_ req: Request) throws -> Future<Response> {
		
		let _ = try req.requireAuthenticated(User.self)

		let users = User.query(on: req).all()
		let usersResponse = users.flatMap { (users) -> Future<Response> in

			let usersResponse = users.compactMap({ user -> UserResponse? in
				return user.toUserResponse()
			})

			return try usersResponse.encode(for: req)
		}

		return usersResponse
	}

}
