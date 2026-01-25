import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppStateManager
    @StateObject private var viewModel = LoginViewModel() // Your existing LoginVM
    @State private var showSignUp = false
    
    var body: some View {
        VStack(spacing: 25) {
            
            // 1. Header
            Spacer()
            VStack(spacing: 10) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Sign in to continue")
                    .foregroundColor(.gray)
            }
            Spacer()
            
            // 2. Form Fields
            VStack(spacing: 15) {
                TextField("Email Address", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .overlay(
                        HStack { Spacer(); Image(systemName: "envelope.fill").foregroundColor(.gray).padding() }
                    )
               
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay(
                        HStack { Spacer(); Image(systemName: "key.fill").foregroundColor(.gray).padding() }
                    )
               
                // MARK: Forgot Password Link (Fixed)
                HStack {
                    Spacer()
                    NavigationLink(destination: ForgotPasswordEmailView()) {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)
            
            // 3. Login Button
            Button(action: {
                viewModel.login {
                    withAnimation { appState.currentState = .home }
                }
            }) {
                if viewModel.isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text("Log In")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            .disabled(viewModel.isLoading)
            
            Spacer()
            
            // 4. Sign Up Link
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
#Preview {
    LoginView()
        .environmentObject(AppStateManager())
}
