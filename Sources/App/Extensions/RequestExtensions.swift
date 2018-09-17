//
//  RequestExtensions.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Foundation
import Vapor

extension Request {
	func print() throws {
		let req = self
		let logger = try req.make(Logger.self)
		logger.debug("method: \(req.http.method)")
		logger.debug("path: \(req.http.url.path)")
		logger.debug("query: \(req.http.url.query ?? "")")
		for header in req.http.headers {
			logger.debug("header: \(header)")
		}
		
		logger.debug("body: \(req.http.body)")
		
		for parameter in req.parameters.values {
			logger.debug("parameter: \(parameter)")
		}
	}
}
