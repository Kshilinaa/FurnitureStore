//
//  VerificationView.swift
//  FurnitureStore
//
import SwiftUI

//MARK: - Constants
private enum Constants {
    static let verificationCodeLabel = "Verification code"
    static let verificationLabel = "Verification"
    static let checkSMSTitle = "Check the SMS"
    static let messageToGetCode = "message to get verification code"
    static let okTitle = "Ok"
    static let continueButtonTitle = "Continue"
    static let sendSMSButtonText = "Send sms again"
    static let verificationCodeTitle = "Verification Code"
    static let verificationCodeMessage = "Fill in from message: "
    static let textColor = "textColor"
    static let bottomGradient = "bottomGradient"
    static let topGragient = "topGragient"
    static let letter = "letter"
    static let gradientNavPanelWidth: CGFloat = 395
    static let gradientNavPanelHeight: CGFloat = 80
}

/// Модификатор текстового поля для ввода одного символа
struct TextFieldCode: ViewModifier {
    @Binding var text: String
    let maxLength: Int

    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .font(.system(size: 40))
            .frame(width: 60)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onChange(of: text) { newValue in
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
    }
}
/// Экран  верификации
struct VerificationView: View {
    @ObservedObject var viewModel = VerificationViewModel()
    @FocusState private var focusedField: Int? // Фокус состояния

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    gradientPanel
                    Image(Constants.letter)
                    verificationCodeLabel
                    Spacer().frame(height: 14)
                    makeTextField
                    Spacer().frame(height: 20)
                    checkSMSLabels
                    continueButton
                    sendSmsButton
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                verificationAlert
            }
        }
    }

    private var gradientPanel: some View {
            HStack {
                LinearGradient(colors: [Color(Constants.bottomGradient), Color(Constants.topGragient)], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
            }
            .frame(width: Constants.gradientNavPanelWidth, height: Constants.gradientNavPanelHeight)
        }
    
    private var verificationCodeLabel: some View {
        Text(Constants.verificationCodeLabel)
            .font(.system(size: 20))
            .foregroundColor(Color(Constants.textColor))
    }

    private var checkSMSLabels: some View {
        VStack(spacing: 6) {
            Text(Constants.checkSMSTitle)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color(Constants.textColor))
            Divider()
                .frame(width: 150, height: 1)
                .overlay(Color(Constants.textColor))
                .padding(.top, -12)
            VStack() {
                Text(Constants.messageToGetCode)
            }
            .font(.system(size: 16))
            .foregroundColor(Color(Constants.textColor))
        }
        .padding(.horizontal, 45)
        .padding()
    }

    private var continueButton: some View {
        Button(action: {

        }, label: {
            Text(Constants.continueButtonTitle)
                .fontWeight(.heavy)
                .font(.system(size: 23))
                .foregroundColor(.white)
        })
        .frame(width: 300, height: 55)
        .background(LinearGradient(colors: [Color(Constants.bottomGradient), Color(Constants.topGragient)], startPoint: .leading, endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(color: .gray, radius: 2, x: 0.0, y: 4.0)
    }

    private var makeTextField: some View {
        HStack {
            TextField("", text: $viewModel.firstNumber)
                .modifier(TextFieldCode(text: $viewModel.firstNumber, maxLength: 1))
                .focused($focusedField, equals: 0)
                .onChange(of: viewModel.firstNumber) { _ in
                    if viewModel.firstNumber.count == 1 {
                        focusedField = 1
                    }
                }
                .onChange(of: viewModel.firstNumber, perform: { value in
                    if value.isEmpty {
                        viewModel.focusedField = nil
                    }
                })

            TextField("", text: $viewModel.secondNumber)
                .modifier(TextFieldCode(text: $viewModel.secondNumber, maxLength: 1))
                .focused($focusedField, equals: 1)
                .onChange(of: viewModel.secondNumber) { _ in
                    if viewModel.secondNumber.count == 1 {
                        focusedField = 2
                    } else if viewModel.secondNumber.isEmpty {
                        focusedField = 0
                    }
                }
                .onChange(of: viewModel.secondNumber, perform: { value in
                    if value.isEmpty {
                        viewModel.focusedField = nil
                    }
                })

            TextField("", text: $viewModel.thirdNumber)
                .modifier(TextFieldCode(text: $viewModel.thirdNumber, maxLength: 1))
                .focused($focusedField, equals: 2)
                .onChange(of: viewModel.thirdNumber) { _ in
                    if viewModel.thirdNumber.count == 1 {
                        focusedField = 3
                    } else if viewModel.thirdNumber.isEmpty {
                        focusedField = 1
                    }
                }
                .onChange(of: viewModel.thirdNumber, perform: { value in
                    if value.isEmpty {
                        viewModel.focusedField = nil
                    }
                })

            TextField("", text: $viewModel.fourthNumber)
                .modifier(TextFieldCode(text: $viewModel.fourthNumber, maxLength: 1))
                .focused($focusedField, equals: 3)
                .onChange(of: viewModel.fourthNumber) { _ in
                    if viewModel.fourthNumber.isEmpty {
                        focusedField = 2
                    }
                }
                .onChange(of: viewModel.fourthNumber, perform: { value in
                    if value.isEmpty {
                        viewModel.focusedField = nil
                    }
                })
        }
        .padding(.horizontal, 20)
    }

    private var sendSmsButton: some View {
        VStack(spacing: 6) {
            Text(Constants.checkSMSTitle)
                .font(.system(size: 16))
                .foregroundColor(Color(Constants.textColor))
                .padding(.top, 10)
            VStack() {
                Button(action: {
                    viewModel.sendSmsAgain()
                }) {
                    Text(Constants.sendSMSButtonText)
                        .underline(color: .gray)
                }
            }
            .font(.system(size: 20))
            .foregroundColor(Color(Constants.textColor))

        }
        .padding(.horizontal, 45)
    }

    private var verificationAlert: Alert {
        Alert(title: Text(Constants.verificationCodeTitle),
              message: Text(Constants.verificationCodeMessage + viewModel.alertCode),
              primaryButton: .default(Text(Constants.okTitle), action: {
                viewModel.fillCode()
              }),
              secondaryButton: .cancel()
        )
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
