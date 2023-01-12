//
//  AuthError.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation

public enum AuthError: Error {
    case networkError // 네트워크 오류
    case weakPassword // 암호가 조건보다 취약함
    case wrongPassword // 잘못된 암호로 로그인 시도
    case userNotFound // 사용자 계정이 존재하지 않음
    case invalidEmail // 이메일 형식이 올바르지 않음
    case emailAlreadyInUse // 이미 등록된 이메일 주소
    case unknown // 알 수 없는 오류
    
    var description: String {
        switch self {
        case .networkError:
            return "통신 오류 입니다."
        case .weakPassword:
            return "비밀번호가 취약합니다."
        case .wrongPassword:
            return "잘못된 이메일 주소 또는 비밀번호 입니다."
        case .userNotFound:
            return "존재하지 않는 계정입니다."
        case .invalidEmail:
            return "올바르지 않은 이메일 형식입니다."
        case .emailAlreadyInUse:
            return "이미 등록된 이메일 아이디 입니다."
        case .unknown:
            return "알 수 없는 에러입니다."
        }
    }
}
