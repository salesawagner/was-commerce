import Crypto
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

	let authController = AuthController()
	try authController.boot(router: router)

	let userController = UserController()
	try userController.boot(router: router)

}
