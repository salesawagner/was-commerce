//
//  RouteCollectionEctension.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

extension RouteCollection {
	func getTokenAuthGroup(router: Router) -> Router {
		let tokenAuthMiddleware = User.tokenAuthMiddleware()
		let guardAuthMiddleware = User.guardAuthMiddleware()
		let tokenAuthGroup = router.grouped(tokenAuthMiddleware, guardAuthMiddleware)
		return tokenAuthGroup
	}
}
