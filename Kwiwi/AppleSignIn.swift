//
//  test.swift
//  Kwiwi
//
//  Created by NULL on 10/23/22.
//

//import SwiftUI
//import AuthenticationServices
//struct test: View {
//    @State private var currentNonce:String?
//    var body: some View {
//        SignInWithAppleButton(.continue,
//            onRequest: { request in
//            let nonce = AuthFile.randomNonceString()
//            currentNonce = nonce
//            request.requestedScopes = [.fullName, .email]
//            request.nonce = AuthFile.sha256(nonce)
//            },
//            onCompletion: { result in
//            switch result {
//            case .success(let authResult):
//                switch authResult.credential {
//                case let appleIDCredential as ASAuthorizationAppleIDCredential: break
//                default:
//                    break
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            }
//        )
//     
//        .padding()
//        .frame(width: 300, height:  90)
//        .foregroundColor(.black)
//        .font(.title2)
//        .background(Color(.white))
//        .cornerRadius(50.0)
//        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
//        .padding(.horizontal)
//
//    }
//}
//
//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        test()
//    }
//}
