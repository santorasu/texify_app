import SwiftUI

struct ForgotPasswordEmailView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 15) {
                Image(systemName: "envelope.badge.shield.half.filled")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Reset Password")
                    .font(.title).bold()
                
                Text("Enter your email. We'll send a 6-digit code.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 40)
            
            CustomTextField(icon: "envelope.fill", placeholder: "Email Address", text: $viewModel.email)
            
            PrimaryButton(title: "Send Code", isLoading: viewModel.isLoading) {
                viewModel.sendOtp()
            }
            
            Spacer()
        }
        .padding(30)
        // Navigate to Step 2
        .navigationDestination(isPresented: $viewModel.navigateToOTP) {
            ForgotPasswordOTPView(viewModel: viewModel)
        }
    }
}

#Preview {
    ForgotPasswordEmailView()
        .environmentObject(AppStateManager())
}
