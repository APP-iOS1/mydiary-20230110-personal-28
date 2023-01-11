//
//  AuthResponse .swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation
import FirebaseAuth

struct AuthResponse {
  var isSuccessed: Bool = false
  var message: String = ""
  var currentUser: User?
}
