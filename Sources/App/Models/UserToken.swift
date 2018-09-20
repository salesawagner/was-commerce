//
//  AuthController.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Authentication
import Crypto
import FluentSQLite
import Vapor

/// Fazer o login e gerar token de acesso para os endpoints que necessitam de autenticação.
final class UserToken: SQLiteModel {

    static func create(userID: Login.ID) throws -> UserToken {
        let string = try CryptoRandom().generateData(count: 16).base64EncodedString()
        return .init(string: string, userID: userID)
    }

    static var deletedAtKey: TimestampKey? { return \.expiresAt }
	
    /// ID  do token gerado
    var id: Int?
	
	/// Token para autenticação
	var string: String
	
	/// ID do usuário logado
	var userID: Login.ID
	
	/// Description
	var expiresAt: Date?

	init(id: Int? = nil, string: String, userID: Login.ID) {
        self.id = id
        self.string = string
        // set token to expire after 5 hours
        self.expiresAt = Date.init(timeInterval: 60 * 60 * 5, since: .init())
        self.userID = userID
    }
}

extension UserToken {
    var user: Parent<UserToken, Login> {
        return parent(\.userID)
    }
}

extension UserToken: Token {
    typealias UserType = Login

	static var tokenKey: WritableKeyPath<UserToken, String> {
        return \.string
    }

	static var userIDKey: WritableKeyPath<UserToken, Login.ID> {
        return \.userID
    }
}

extension UserToken: Migration {
    static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(UserToken.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.string)
            builder.field(for: \.userID)
            builder.field(for: \.expiresAt)
            builder.reference(from: \.userID, to: \Login.id)
        }
    }
}

extension UserToken: Content { }

extension UserToken: Parameter { }
