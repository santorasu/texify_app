import SwiftUI
import Combine

class AppStateManager: ObservableObject {
    @Published var currentState: AppState = .splash
    @Published var resetID = UUID()
}
