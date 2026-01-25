import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppStateManager
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea() // Light gray bg
            
            VStack {
                // Skip Button
                HStack {
                    Spacer()
                    Button("Skip") {
                        appState.currentState = .login
                    }
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                }
                
                // Page View
                TabView(selection: $viewModel.currentPage) {
                    ForEach(viewModel.pages.indices, id: \.self) { index in
                        OnboardingPageView(page: viewModel.pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Bottom Button
                if viewModel.isLastPage {
                    Button(action: {
                        appState.currentState = .login
                    }) {
                        Text("Get Started")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                    // Spacer to keep layout consistent when button is missing
                    Spacer().frame(height: 100)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.isLastPage)
    }
}

// Subview
struct OnboardingPageView: View {
    let page: OnboardingViewModel.Page
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: page.image)
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .foregroundColor(.blue)
                .padding()
                .background(Circle().fill(Color.blue.opacity(0.1)).frame(width: 250, height: 250))
            
            VStack(spacing: 15) {
                Text(page.title)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(page.desc)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 30)
            }
        }
        .padding(.bottom, 50)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppStateManager())
}
