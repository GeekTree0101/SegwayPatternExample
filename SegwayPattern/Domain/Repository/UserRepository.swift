//
//  UserRepository.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

protocol UserRepository {
  func userByID(_ id: Int) async -> Result<User, Error>
  func me() async -> User
}

final class DefaultUserRepository: UserRepository {

  func userByID(_ id: Int) async -> Result<User, Error> {
    guard let user = self.dummyUsers.first(where: { $0.id == id }) else {
      return .failure(NSError(domain: "not found", code: 404, userInfo: nil))
    }
    return .success(user)
  }

  func me() async -> User {
    return User(id: 1, name: "david")
  }

  private let dummyUsers = [
    User(id: 1, name: "david"),
    User(id: 2, name: "marty"),
    User(id: 3, name: "ray"),
    User(id: 4, name: "daniel"),
    User(id: 5, name: "ryan"),
    User(id: 6, name: "lychee")
  ]
}
