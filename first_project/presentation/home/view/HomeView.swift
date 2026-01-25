import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppStateManager
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
                .padding()
            
            Text("Login Successful!")
                .font(.title)
                .bold()
            
            Button("Log Out") {
                withAnimation {
                    appState.currentState = .login
                }
            }
            .padding()
            .background(Color.red.opacity(0.1))
            .foregroundColor(.red)
            .cornerRadius(10)
            .padding(.top, 20)
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(AppStateManager())
}
