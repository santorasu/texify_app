import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        ZStack {
            switch appState.currentState {
            case .splash:
                SplashScreen()
            case .onboarding:
                OnboardingView()
            case .login:
                NavigationStack {
                    LoginView()
                }
                .id(appState.resetID) // <--- ADD THIS
            case .home:
                HomeView()
            }
        }
        .animation(.easeInOut, value: appState.currentState)
    }
}
#Preview {
    RootView()
        .environmentObject(AppStateManager())
}
