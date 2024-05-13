//
//  PaymentView.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 10.05.2024.
//
import SwiftUI

struct PaymentView: View {
    //MARK: - Constants
    private enum Constants {
        static let topGradient = "topGragient"
        static let bottomGradient = "bottomGradient"
        static let categoryBackground = Color("categoryBackground")
        static let customDarkGreen = "customDarkGreen"
        static let customDarkGray = "customDarkGray"
        static let backButtonImage = "chevron.backward"
        static let title = "Payment"
        static let logoMir = "logoMir"
        static let cardNumberTitle = "Card number"
        static let yourNameTitle = "Your Name"
        static let addNow = "Add now"
        static let cardholderTitle = "Cardholder"
        static let cardholderNameTitle = "Cardholder Name"
        static let zeroCardNumber = "0000 0000 0000 0000"
        static let cardNumberPlaceholder = "**** **** **** 0000"
        static let addCard = "Add new card"
        static let month = "Month"
        static let year = "Year"
        static let cvc = "CVC"
        static let cvcPromt = "000"
        static let cvcCVV = "CVC/CVV"
        static let valid = "Valid"
        static let cvcAlertMessage = "CVC должен иметь 3 цифры"
        static let successAlertMessage = "Карта успешно добавлена"
        static let maxCardNumberLength = 16
        static let duration = 0.3
    }
    //MARK: - State
    @State private var passwordIsHide = true
    @State private var cardHolder = ""
    @State private var cardNumber = ""
    @State private var dateNumber = "1"
    @State private var yearNumber = "2024"
    @State private var cvc = ""
    @State private var frontDegree = 0.0
    @State private var backDegree = 90.0
    @State private var isFlipped = false
    @State private var iscvcAlertShown = false
    @State private var isSuccessAlertShown = false
    //MARK: - Body
    var body: some View {
        VStack {
            LinearGradient(colors: [Color(Constants.topGradient), Color(Constants.bottomGradient)], startPoint: .leading, endPoint: .trailing)
                .frame(height: 100)
                .ignoresSafeArea(edges: .top)
            ScrollView {
                ZStack {
                    frondSideCardView
                    backSideFrontView
                }
                .onTapGesture {
                    flipCard()
                }
                paymentCardForm
                datePickerView
                cvcEntryFormView
            }
            .padding(.top, -70)
            Spacer()
            addNewButtonView
        }
    }
    // MARK: - Visual Components
    private var frondSideCardView: some View {
        VStack(alignment: .leading) {
            ZStack {
                LinearGradient(colors: [Color(Constants.topGradient), Color(Constants.bottomGradient)], startPoint: .leading, endPoint: .trailing)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 30)
                    .shadow(radius: 3, y: 3)
                VStack(alignment: .leading) {
                    Image(Constants.logoMir)
                        .padding(.leading, 230)
                    Group {
                        Text(cardNumberSecurePlaceholder)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.cardNumberTitle)
                            .foregroundStyle(Constants.categoryBackground)
                            .font(.system(size: 16))
                        Spacer()
                            .frame(height: 20)
                        Text(Constants.yourNameTitle)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(cardholderPlaceholder)
                            .foregroundStyle(Constants.categoryBackground)
                            .font(.system(size: 16))
                    }
                    .padding(.trailing, 100)
                }
            }
        }
        .rotation3DEffect(
            Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private var cardNumberPlaceholder: String {
        cardNumber.count == 16 ? cardNumber : Constants.zeroCardNumber
    }
    
    private var cardNumberSecurePlaceholder: String {
        if cardNumber.count == 16 {
            let lastSymbols = String(cardNumber.suffix(4))
            return "**** **** **** " + lastSymbols
        } else {
            return Constants.cardNumberPlaceholder
        }
    }
    
    private var paymentCardForm: some View {
        VStack(alignment: .leading) {
            Text(Constants.addCard)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(Color(Constants.customDarkGreen))
            TextField("", text: $cardHolder, prompt: Text(Constants.cardholderNameTitle))
                .foregroundStyle(Color(Constants.customDarkGreen))
                .font(.system(size: 20))
            Divider()
            Text(Constants.cardNumberTitle)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(Color(Constants.customDarkGreen))
            if #available(iOS 17.0, *) {
                TextField("", text: $cardNumber, prompt: Text(Constants.zeroCardNumber))
                    .foregroundStyle(Color(Constants.customDarkGreen))
                    .font(.system(size: 20))
                    .keyboardType(.decimalPad)
                    .onChange(of: cardNumber) { oldValue, _ in
                        if cardNumber.count > Constants.maxCardNumberLength {
                            cardNumber = oldValue
                        }
                    }
            }
            Divider()
        }
        .padding()
    }
    
    private var datePickerView: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(Constants.month)
                        .font(.system(size: 20))
                    Picker(selection: $dateNumber) {
                        ForEach (1...12, id: \.self) {Text("\($0)").tag("\($0)")}
                    } label: {
                        Text("")
                            .foregroundStyle(Color(Constants.customDarkGreen))
                    }
                    .pickerStyle(.menu)
                }
                Divider()
            }
            .padding(.trailing, 40)
            VStack(alignment: .leading) {
                HStack {
                    Text(Constants.year)
                        .font(.system(size: 20))
                    Picker(selection: $yearNumber) {
                        ForEach (0...10, id: \.self) {Text(String(2024 + $0)).tag(String(2024 + $0))}
                    } label: {
                        Text(Constants.year)
                    }
                    .pickerStyle(.menu)
                }
                Divider()
            }
            .padding(.trailing, 40)
        }
        .tint(Color(Constants.customDarkGray))
        .padding(.horizontal)
    }
    
    private var cardholderPlaceholder: String {
        cardHolder.isEmpty ? Constants.cardholderTitle : cardHolder
    }
    
    private var cvcEntryFormView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(Constants.cvc)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(Color(Constants.customDarkGray))
            HStack {
                if #available(iOS 17.0, *) {
                    if passwordIsHide {
                        SecureField("***", text: $cvc)
                            .font(.system(size: 20))
                            .foregroundStyle(Color(Constants.customDarkGray))
                            .keyboardType(.decimalPad)
                            .onChange(of: cvc) { oldValue, _ in
                                if cvc.count == 4 {
                                    cvc = oldValue
                                }
                            }
                    } else {
                        TextField("***", text: $cvc)
                            .font(.system(size: 20))
                            .foregroundStyle(Color(Constants.customDarkGray))
                            .keyboardType(.decimalPad)
                            .onChange(of: cvc) { oldValue, _ in
                                if cvc.count == 4 {
                                    cvc = oldValue
                                }
                            }
                    }
                    Button(action: {
                        passwordIsHide.toggle()
                    }){
                        Image(systemName: passwordIsHide ? "eye.slash" : "eye")
                            .foregroundStyle(Color(Constants.customDarkGray))
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var cvcPlaceholder: String {
        cvc.count == Constants.cvcPromt.count ? cvc : Constants.cvcPromt
    }
    
    private var backSideFrontView: some View {
        ZStack {
            LinearGradient(colors: [Color(Constants.topGradient), Color(Constants.bottomGradient)], startPoint: .leading, endPoint: .trailing)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 30)
                .shadow(radius: 3, y: 3)
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    Text(cardNumberPlaceholder)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    HStack {
                        Text(Constants.cvc)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.cvcCVV)
                            .foregroundStyle(Constants.categoryBackground)
                            .font(.system(size: 16))
                    }
                    HStack {
                        Text(Constants.month)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.valid)
                            .foregroundStyle(Constants.categoryBackground)
                            .font(.system(size: 16))
                    }
                }
                .padding(.trailing, 50)
            }
        }
        .rotation3DEffect(
            Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: Constants.duration)) {
                frontDegree = -90
                withAnimation(.linear(duration: Constants.duration).delay(Constants.duration)){
                    backDegree = 0
                }
            }
        } else {
            withAnimation(.linear(duration: Constants.duration).delay(Constants.duration)){
                frontDegree = 0
            }
            withAnimation(.linear(duration: Constants.duration)) {
                backDegree = 90
            }
        }
    }
    
    private var addNewButtonView: some View {
        Button {
            addNewButtonAction()
        }
    label: {
        Text(Constants.addNow)
            .padding(.vertical, 20)
            .padding(.horizontal, 120)
            .font(.title2.bold())
            .background(
                LinearGradient(colors: [Color(Constants.topGradient), Color(Constants.bottomGradient)], startPoint: .leading, endPoint: .trailing)
            )
            .foregroundStyle(.white)
    }
    .cornerRadius(27)
    .shadow(color: .gray, radius: 2, x: 0.0, y: 3.0)
    .padding(.bottom, 20)
    .alert(Constants.successAlertMessage, isPresented: $isSuccessAlertShown, actions: {})
    .alert(Constants.cvcAlertMessage, isPresented: $iscvcAlertShown, actions: {})
    }
    
    private func addNewButtonAction() {
        if cvc.count == 3 {
            isSuccessAlertShown = true
        } else { iscvcAlertShown = true}
    }
    
}

#Preview {
    PaymentView()
}
