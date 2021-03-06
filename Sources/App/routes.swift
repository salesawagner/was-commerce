import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
	try router.register(collection: AuthController())
	try router.register(collection: UserController())
	try router.register(collection: ProductController())
	try router.register(collection: CartController())
}
