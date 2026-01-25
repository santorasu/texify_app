import SwiftUI

struct NewPasswordView: View {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    @EnvironmentObject var appState: AppStateManager
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Header
            VStack(spacing: 10) {
                Image(systemName: "shield.check.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                Text("New Password")
                    .font(.title).bold()
                
                Text("Create a secure password.")
                    .foregroundColor(.gray)
            }
            .padding(.top, 40)
            
            // Inputs
            VStack(spacing: 15) {
                CustomSecureField(icon: "lock.fill", placeholder: "New Password", text: $viewModel.newPassword)
                CustomSecureField(icon: "checkmark.shield.fill", placeholder: "Confirm Password", text: $viewModel.confirmPassword)
            }
            
            // Action Button
            PrimaryButton(title: "Update Password", isLoading: false, color: .green) {
                
                // ✅ ACTION: This forces RootView to destroy the old Login stack
                // and create a fresh one immediately.
                appState.resetID = UUID()
                
                // Optional: Ensure state is login (redundant but safe)
                appState.currentState = .login
                
                // Cleanup inputs
                viewModel.newPassword = ""
                viewModel.confirmPassword = ""
            }
            
            Spacer()
        }
        .padding(30)
    }
}

#Preview {
    let vm = ForgotPasswordViewModel()
    return NewPasswordView(viewModel: vm)
        .environmentObject(AppStateManager())
}
