//
//  splash_viewmodel.swift
//  first_project
//
//  Created by Mac Mini- 04 on 25/1/26.
//

import SwiftUI // <--- CHANGE THIS (was Foundation)
import Combine // Optional, but good practice

// 1. Ensure this is a 'class', NOT a 'struct'
class SplashViewModel: ObservableObject {
    
    @Published var isActive: Bool = false
    
    init() {
        startSplashTimer()
    }
    
    func startSplashTimer() {
        // 2. Ensuring this runs on the main thread is safer
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isActive = true
        }
    }
}
