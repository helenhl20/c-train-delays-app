import SwiftUI
import UserNotifications

@main
struct CTrainDelaysApp: App {
    @StateObject private var statusManager = CTrainStatusManager()

    init() {
        // Request notification permissions on launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print("Notification permission granted: \(granted)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(statusManager)
                .onAppear {
                    statusManager.fetchStatus()
                }
        }
    }
}
