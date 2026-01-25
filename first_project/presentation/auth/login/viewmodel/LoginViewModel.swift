import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: String?

    func login(success: @escaping () -> Void) {
        isLoading = true
        error = nil
        
        // Simulate Network Call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            if self.email.lowercased() == "test@gmail.com" && self.password == "123456" {
                success()
            } else {
                self.error = "Invalid credentials. Try test@gmail.com / 123456"
            }
        }
    }
}
