//
//  UserStore.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation
import FirebaseAuth

class AuthStore {
    private let auth = Auth.auth()
    
    // MARK: Sign Up Method
    func signUp(emailID: String, password: String) async -> AuthResponse {
        var signUpResponse: AuthResponse = AuthResponse()
        
        do {
            let result = try await auth.createUser(withEmail: emailID, password: password)
            signUpResponse = AuthResponse(isSuccessed: true, message: "회원가입이 완료되었습니다.", currentUser: result.user)
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                signUpResponse = AuthResponse(isSuccessed: false, message: AuthError.networkError.description)
            case .weakPassword:
                signUpResponse = AuthResponse(isSuccessed: false, message: AuthError.weakPassword.description)
            default:
                signUpResponse = AuthResponse(isSuccessed: false, message: AuthError.unknown.description)
            }
        }
        
        return signUpResponse
    }
    
    // MARK: Check email address is duplicated
    func checkDuplicatedEmail(emailID: String) async -> DuplicatedResponse {
        var checkDuplicatedResponse: DuplicatedResponse = DuplicatedResponse()
        
        do {
            let result = try await auth.fetchSignInMethods(forEmail: emailID)
            if result.isEmpty { // 메일이 중복되지 않음
                checkDuplicatedResponse = DuplicatedResponse(isSuccessed: true, isDuplicated: false, message: "사용 가능한 이메일 아이디 입니다.")
            } else { // 중복된 메일
                checkDuplicatedResponse = DuplicatedResponse(isSuccessed: true, isDuplicated: true, message: "이미 등록된 이메일 아이디 입니다.")
            }
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                checkDuplicatedResponse = DuplicatedResponse(isSuccessed: false, isDuplicated: false, message: AuthError.networkError.description)
            default:
                checkDuplicatedResponse = DuplicatedResponse(isSuccessed: false, isDuplicated: false, message: AuthError.unknown.description)
            }
        }
        
        return checkDuplicatedResponse
    }
    
    // MARK: Sign In Method
    func signIn(emailID: String, password: String) async -> AuthResponse {
        var signInResponse: AuthResponse = AuthResponse()
        
        do {
            let result = try await auth.signIn(withEmail: emailID, password: password)
            signInResponse = AuthResponse(isSuccessed: true, message: "로그인 성공!", currentUser: result.user)
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                signInResponse = AuthResponse(isSuccessed: false, message:  AuthError.networkError.description)
            case .weakPassword:
                signInResponse = AuthResponse(isSuccessed: false, message:  AuthError.weakPassword.description)
            case .wrongPassword:
                signInResponse = AuthResponse(isSuccessed: false, message:  AuthError.wrongPassword.description)
            case .invalidEmail:
                signInResponse = AuthResponse(isSuccessed: false, message:  AuthError.invalidEmail.description)
            case .userNotFound:
                signInResponse = AuthResponse(isSuccessed: false, message:  AuthError.userNotFound.description)
            default:
                signInResponse = AuthResponse(isSuccessed: false, message:  AuthError.unknown.description)
            }
        }
        
        return signInResponse
    }
    
    // MARK: Reset password
    func resetPassword(emailID: String) async -> ResetPasswordResponse {
        var resetResponse: ResetPasswordResponse = ResetPasswordResponse()
        
        do {
            try await auth.sendPasswordReset(withEmail: emailID)
            resetResponse = ResetPasswordResponse(isSuccessed: true, message: "비밀번호 확인 메일이 발송되었습니다.")
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                resetResponse = ResetPasswordResponse(isSuccessed: false, message:  AuthError.networkError.description)
            case .userNotFound:
                resetResponse = ResetPasswordResponse(isSuccessed: false, message:  AuthError.userNotFound.description)
            default:
                resetResponse = ResetPasswordResponse(isSuccessed: false, message:  AuthError.unknown.description)
            }
        }
        
        return resetResponse
    }
    
    // MARK: Sign Out Method
    func signOut() async -> AuthResponse {
        var signOutResponse: AuthResponse = AuthResponse()
        
        do {
            try auth.signOut()
            signOutResponse = AuthResponse(isSuccessed: true, message: "SignOut Successed", currentUser: nil)
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                signOutResponse = AuthResponse(isSuccessed: false, message: AuthError.networkError.description)
            default:
                signOutResponse = AuthResponse(isSuccessed: false, message: AuthError.unknown.description)
            }
        }
        
        return signOutResponse
    }
    
    // MARK: Change displayName
    func changeDisplayName(nickname: String) async {
        guard let currentUser = auth.currentUser else { return }
        
        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = nickname
        
        do {
            try await changeRequest.commitChanges()
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                print(AuthError.networkError.description)
            default:
                print(AuthError.unknown.description)
            }
        }
    }
    
    // MARK: Change Profile Photo
    func changeProfilePhoto(photoURL: String) async {
        guard let currentUser = auth.currentUser else { return }
        
        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.photoURL = URL(string: photoURL)
        
        do {
            try await changeRequest.commitChanges()
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
            case .networkError:
                print(AuthError.networkError.description)
            default:
                print(AuthError.unknown.description)
            }
        }
    }
}
