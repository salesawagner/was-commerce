import Crypto
import Vapor
import FluentSQLite

/// Creates new users and logs them in.
final class UserController {
	
	func boot(router: Router) throws {
		let group = router.grouped("user")
		try self.get(group: group)
		try self.post(group: group)
	}
	
	func get(group: Router) throws {
		group.get("list", use: list)
	}
	
	func post(group: Router) throws {
		group.post("create", use: create)
	}
	
	func create(_ req: Request) throws -> Future<UserResponse> {
		
		let user = try req.content.decode(CreateUserRequest.self).flatMap { user -> Future<User> in

			guard user.password == user.verifyPassword else {
				throw Abort(.badRequest, reason: "Password and verification must match.")
			}

			let hash = try BCrypt.hash(user.password)
			let user = User(id: nil, name: user.name, email: user.email, passwordHash: hash)
			let futureUser = user.save(on: req)

			return futureUser
		}

		return user.map { user in
			return try UserResponse(id: user.requireID(), name: user.name, email: user.email)
		}
	}

	func list(_ req: Request) throws -> Future<Response> {
		let users = User.query(on: req).all()

		let usersResponse = users.flatMap { (users) -> Future<Response> in

			let usersResponse = users.compactMap({ user -> UserResponse? in
				guard let id = user.id else { return nil }
				return UserResponse(id: id, name: user.name, email: user.email)
			})

			return try usersResponse.encode(for: req)
		}

		return usersResponse
	}
	
    /// Logs a user in, returning a token for accessing protected endpoints.
    func login(_ req: Request) throws -> Future<UserToken> {
        // get user auth'd by basic auth middleware
        let user = try req.requireAuthenticated(User.self)
        
        // create new token for this user
        let token = try UserToken.create(userID: user.requireID())
        
        // save and return token
        return token.save(on: req)
    }
}
