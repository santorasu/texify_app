import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) var dismiss // Go back to previous screen
    
    var body: some View {
        ZStack {
            // Background Color
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    // 1. Header Section
                    VStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.system(size: 70))
                            .foregroundColor(.blue)
                            .padding(.bottom, 10)
                        
                        Text("Create Account")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Join BanglaScan to save your history and sync across devices.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 40)
                    
                    // 2. Form Section
                    VStack(spacing: 20) {
                        CustomTextField(icon: "person.fill", placeholder: "Full Name", text: $viewModel.fullName)
                        
                        CustomTextField(icon: "envelope.fill", placeholder: "Email Address", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                        
                        CustomSecureField(icon: "lock.fill", placeholder: "Password", text: $viewModel.password)
                        
                        CustomSecureField(icon: "checkmark.shield.fill", placeholder: "Confirm Password", text: $viewModel.confirmPassword)
                    }
                    .padding(.horizontal)
                    
                    // 3. Sign Up Button
                    Button(action: {
                        viewModel.register {
                            dismiss()
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text("Create Account")
                                .fontWeight(.bold)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(Color.blue) // Changed to Blue to match App Theme
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // 4. "Already have an account?" Footer
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            dismiss() // Pop back to Login
                        }) {
                            Text("Log In")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .onTapGesture {
            // Dismiss keyboard when tapping outside
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}


#Preview {
    SignUpView()
}
