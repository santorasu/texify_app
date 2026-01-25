import SwiftUI
import Combine

// MARK: - UI Components
struct PrimaryButton: View {
    var title: String
    var isLoading: Bool = false
    var color: Color = .blue
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text(title).font(.headline).fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: color.opacity(0.3), radius: 5, y: 5)
        }
        .disabled(isLoading)
    }
}

//struct CustomTextField: View {
//    var icon: String
//    var placeholder: String
//    @Binding var text: String
//    var keyboardType: UIKeyboardType = .default
//
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: icon).foregroundColor(.gray).frame(width: 20)
//            TextField(placeholder, text: $text)
//                .keyboardType(keyboardType)
//                .autocapitalization(.none)
//        }
//        .padding()
//        .background(Color(.systemGray6))
//        .cornerRadius(12)
//    }
//}

//struct CustomSecureField: View {
//    var icon: String
//    var placeholder: String
//    @Binding var text: String
//
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: icon).foregroundColor(.gray).frame(width: 20)
//            SecureField(placeholder, text: $text)
//        }
//        .padding()
//        .background(Color(.systemGray6))
//        .cornerRadius(12)
//    }
//}

// MARK: - ViewModel
class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var otpCode: String = "" // 6 Digits
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
    // UI States
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Navigation Flags
    @Published var navigateToOTP: Bool = false
    @Published var navigateToReset: Bool = false
    @Published var isFlowCompleted: Bool = false

    func sendOtp() {
        isLoading = true
        // No validation, just navigate after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = false
            self.navigateToOTP = true
        }
    }
    
    func verifyOtp() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = false
            self.navigateToReset = true
        }
    }
    
    func resetPassword() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = false
            self.isFlowCompleted = true
        }
    }
}
