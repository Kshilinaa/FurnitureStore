//
//  VerificationViewModel.swift
//  FurnitureStore
//
import SwiftUI
/// ViewModel для верификации.
class VerificationViewModel: ObservableObject {
    /// Первая цифра кода.
    @Published var firstNumber = ""
    /// Вторая цифра кода.
    @Published var secondNumber = ""
    /// Третья цифра кода.
    @Published var thirdNumber = ""
    /// Четвертая цифра кода.
    @Published var fourthNumber = ""
    /// Показывать ли alert.
    @Published var showAlert = false
    /// Код для alert.
    @Published var alertCode = ""
    /// Состояние для отслеживания фокуса/
    @Published var focusedField: Int?
    
    // MARK: - Public Methods
    /// Метод для заполнения кода.
    func fillCode() {
        guard alertCode.count == 4 else { return }
        firstNumber = String(alertCode[alertCode.startIndex])
        secondNumber = String(alertCode[alertCode.index(alertCode.startIndex, offsetBy: 1)])
        thirdNumber = String(alertCode[alertCode.index(alertCode.startIndex, offsetBy: 2)])
        fourthNumber = String(alertCode[alertCode.index(alertCode.startIndex, offsetBy: 3)])
    }
    /// Метод для отправки SMS еще раз.
    func sendSmsAgain() {
        let newCode = String(format: "%04d", Int.random(in: 0...9999))
        alertCode = "\(firstNumber)\(secondNumber)\(thirdNumber)\(fourthNumber)"
        showAlert.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alertCode = newCode
        }
    }
}
