import SwiftUI

struct ForgotPasswordOTPView: View {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Image(systemName: "lock.open.rotation")
                    .font(.system(size: 60))
                    .foregroundColor(.purple)
                
                Text("Verification")
                    .font(.title).bold()
                
                Text("Enter the 6-digit code sent to\n\(viewModel.email)")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            // 6-Digit Split Box Design
            ZStack {
                // Invisible TextField for input logic
                TextField("", text: $viewModel.otpCode)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .opacity(0)
                    .onChange(of: viewModel.otpCode) { oldValue, newValue in
                        if newValue.count > 6 {
                            viewModel.otpCode = String(newValue.prefix(6))
                        }
                    }

                // Visual Boxes
                HStack(spacing: 10) {
                    ForEach(0..<6, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(index == viewModel.otpCode.count ? Color.purple : Color.gray.opacity(0.3), lineWidth: 2)
                            .background(Color(.systemGray6))
                            .frame(width: 45, height: 55)
                            .overlay(
                                Text(getDigit(at: index))
                                    .font(.title)
                                    .fontWeight(.bold)
                            )
                    }
                }
            }
            .onAppear { isFocused = true }
            
            PrimaryButton(title: "Verify", isLoading: viewModel.isLoading, color: .purple) {
                viewModel.verifyOtp()
            }
            
            Spacer()
        }
        .padding(30)
        // Navigate to Step 3
        .navigationDestination(isPresented: $viewModel.navigateToReset) {
            NewPasswordView(viewModel: viewModel)
        }
    }
    
    private func getDigit(at index: Int) -> String {
        if index < viewModel.otpCode.count {
            let start = viewModel.otpCode.index(viewModel.otpCode.startIndex, offsetBy: index)
            return String(viewModel.otpCode[start])
        }
        return ""
    }
}
// ✅ FIXED: Preview now passes the required viewModel
#Preview {
    ForgotPasswordOTPView(viewModel: ForgotPasswordViewModel())
}

