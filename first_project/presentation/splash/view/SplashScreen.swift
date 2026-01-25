import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var appState: AppStateManager
    
    // Animation States
    @State private var startAnimation = false
    @State private var textOpacity = 0.0
    @State private var textOffset: CGFloat = 20
    
    var body: some View {
        ZStack {
            // 1. Dynamic Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.indigo,
                    Color("BrandPurple"), // If you don't have this, use Color.purple
                    Color.blue
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 2. Ambient Background Glows (Adds Depth)
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 300, height: 300)
                .blur(radius: 60)
                .offset(x: -120, y: -200)
            
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 250, height: 250)
                .blur(radius: 60)
                .offset(x: 120, y: 200)
            
            // 3. Main Content
            VStack(spacing: 10) {
                
                // --- Logo Block ---
                ZStack {
                    // Outer Glow
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: 140, height: 140)
                    
                    // Glass Effect Circle
                    Circle()
                        .fill(.ultraThinMaterial) // iOS Glass effect
                        .frame(width: 120, height: 120)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 10)
                    
                    // Icon
                    Image(systemName: "text.viewfinder") // More specific to "Texify"
                        .font(.system(size: 55))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .scaleEffect(startAnimation ? 1.0 : 0.5)
                .opacity(startAnimation ? 1.0 : 0.0)
                
                // --- Text Block ---
                VStack(spacing: 5) {
                    Text("TexifyAI")
                        .font(.system(size: 50, weight: .black, design: .rounded))
                        .foregroundColor(.black)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                    Text("Smart Text Recognition")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.85))
                        .tracking(1) // Adds spacing between letters
                }
                .opacity(textOpacity)
                .offset(y: textOffset)
                .padding(.top, 20)
            }
        }
        .onAppear {
            // Step 1: Animate Logo Pop
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                startAnimation = true
            }
            
            // Step 2: Animate Text Slide Up (Slight delay)
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                textOpacity = 1.0
                textOffset = 0
            }
            
            // Step 3: Navigate after 2.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    appState.currentState = .onboarding
                }
            }
        }
    }
}

// Preview Provider
#Preview {
    SplashScreen()
        .environmentObject(AppStateManager())
}
