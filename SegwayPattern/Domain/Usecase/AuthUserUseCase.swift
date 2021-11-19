//
//  AuthUserUseCase.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

final class AuthUserUseCase {

  private let userRepository: UserRepository

  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }

  func me() async -> User {
    return await self.userRepository.me()
  }
}
