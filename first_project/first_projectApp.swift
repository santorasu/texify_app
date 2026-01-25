import SwiftUI

@main
struct first_projectApp: App {

    @StateObject private var appState = AppStateManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState) 
        }
    }
}
