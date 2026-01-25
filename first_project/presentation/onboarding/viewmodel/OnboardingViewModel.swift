import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0

    struct Page {
        let image: String
        let title: String
        let desc: String
    }

    let pages: [Page] = [
        .init(image: "doc.viewfinder", title: "Scan Bangla", desc: "Instantly digitize handwritten or printed Bengali text with 99% accuracy."),
        .init(image: "wand.and.stars", title: "AI Correction", desc: "Our smart AI fixes spelling and grammar mistakes automatically."),
        .init(image: "message.fill", title: "Chat with Docs", desc: "Ask questions about your documents and get instant answers.")
    ]

    var isLastPage: Bool {
        currentPage == pages.count - 1
    }
}
