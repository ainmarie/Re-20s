import SwiftUI

@main
struct Re20sApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if !appState.hasSeenOpening {
                OpeningView()
                    .environmentObject(appState)
            } else if appState.isSignedUp {
                MainTabView()
                    .environmentObject(appState)
            } else {
                SignupView()
                    .environmentObject(appState)
            }
        }
    }
}
