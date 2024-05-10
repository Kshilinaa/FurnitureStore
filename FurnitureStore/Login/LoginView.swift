//
//  LoginView.swift
//  FurnitureStore
//
import SwiftUI

struct LoginView: View {
    //MARK: - Constants
    private enum Constants {
        static let singUpColor = "singUpColor"
        static let forgotPasswordAlertText = "Забыли пароль?"
        static let messageAlert = "Обратитесь по номеру тех.поддержки 88005553535"
        static let okAler = "Ок"
        static let logIn = "Log in"
        static let signUp = "Sign up"
        static let regestrationButtonTitle = "Sign up"
        static let pasword = "Password"
        static let paswordPlaceholder = "••••••••"
        static let eye = "eye"
        static let eyeSlash = "eye.slash"
        static let forgotPasswordButtonTitle = "Forgot your password?"
        static let verificationTitle = "Check Verification"
        static let bottomGradient = "bottomGradient"
        static let topGragient = "topGragient"
        static let textColor = "textColor"
            }
    /// Состояния
    @State private var phone = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var shouldShowAlert = false
    @State private var inputText: String = ""
    @State private var isShowDetailView = false
    @State private var isShowLoginView = false
    @FocusState private var loginFocused
    @FocusState private var passwordFocused
    //MARK: - Body
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Rectangle()
                        .fill(.white)
                        .ignoresSafeArea()
                        .overlay {
                            Spacer()
                            VStack {
                                loginAnddSignUpView
                                Spacer()
                                    .frame(maxHeight: 76)
                                formatLoginView
                                Spacer()
                                    .frame(maxHeight: 95)
                                singUpButton
                                Spacer()
                                    .frame(maxHeight: 24)
                                verificationButton
                                Divider()
                                    .frame(width: 160, height: 1.0)
                                    .background(Color(Constants.textColor))
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                        }
                }
                .onTapGesture {
                    loginFocused = false
                    passwordFocused = false
                }
            }
        }
    }
    // MARK: - Visual Components
    private var gradientPanel: some View {
        HStack {
            LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
    }
    
    private var loginAnddSignUpView: some View {
        HStack(spacing: 0) {
            Text(Constants.logIn)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text(Constants.signUp)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(Constants.singUpColor))
        }
        .frame(width: 300, height: 55)
        .font(.system(size: 20))
        .fontWeight(.bold)
        .foregroundStyle(LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .top, endPoint: .bottom))
        .clipShape(Capsule())
        .background {
            Capsule()
                .stroke(Color(Constants.singUpColor), lineWidth: 2.0)
        }
        .padding(.top, 37)
    }
    
    private var formatLoginView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                
                            TextField("Phone number", text: $phone)
                    .focused($loginFocused)
                    .onReceive(phone.publisher.collect()) {
                        self.phone = formatPhoneNumber(
                            with: "+X (XXX) XXX-XX-XX",
                            phone: String($0.prefix(20))
                        )
                        if phone.count == 18 {
                            passwordFocused = true
                        }
                    }
                    .keyboardType(.phonePad)
                Divider()
            }
            
            
            VStack(spacing: 12) {
                Text(Constants.pasword)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                HStack {
                    if isSecure {
                        SecureField(Constants.paswordPlaceholder, text: $password)
                            .focused($passwordFocused)
                            
                    } else {
                        TextField(Constants.paswordPlaceholder, text: $password)
                            .focused($passwordFocused)
                    }
                    
                    Button(action: {
                        isSecure.toggle()
                    }, label: {
                        Image(systemName: isSecure ? Constants.eyeSlash : Constants.eye)
                            .font(.system(size: 20))
                    })
                }
                Divider()
            }
        }
        .font(.system(size: 20))
        .fontWeight(.bold)
        .foregroundStyle(.gray)
    }
    
    private func formatPhoneNumber(with mask: String, phone: String) -> String {
            let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            var result = ""
            var index = numbers.startIndex
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
    private var singUpButton: some View {
        Button(action: {
            isShowDetailView.toggle()
        }, label: {
            Text(Constants.regestrationButtonTitle)
                .fontWeight(.heavy)
                .font(.system(size: 23))
                .foregroundStyle(.white)
        })
        .frame(width: 300, height: 55)
        .background(LinearGradient(colors: [Color(Constants.bottomGradient), Color(Constants.topGragient)], startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(color: .gray, radius: 2, x: 0.0, y: 4.0)
        .fullScreenCover(isPresented: $isShowDetailView, content: {
            DetailView()
        })
    }
    
    private var forgotPasswordButton: some View {
        Button {
            shouldShowAlert.toggle()
        } label: {
            Text(Constants.forgotPasswordButtonTitle)
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(Constants.forgotPasswordAlertText), message: Text(Constants.messageAlert), dismissButton: .default(Text(Constants.okAler)))
        }
        .font(.system(size: 20))
        .fontWeight(.bold)
        .foregroundStyle(Color(Constants.textColor))
    }
    
    private var verificationButton: some View {
        VStack(spacing: 18) {
            forgotPasswordButton
            VStack(spacing: 6) {
                NavigationLink(destination: VerificationView()) {
                    Text(Constants.verificationTitle)
                        .fontWeight(.heavy)
                        .font(.system(size: 20))
                        .foregroundStyle(Color(Constants.textColor))
                }
                .frame(width: 200, height: 34)
            }
            .padding(.horizontal, 45)
        }
    }
    
    
}
struct LogInViewPreviews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
