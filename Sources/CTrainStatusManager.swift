import Foundation
import UserNotifications
#if canImport(UIKit)
import UIKit
#endif

class CTrainStatusManager: ObservableObject {
    @Published var currentStatus: TrainStatus = .loading
    @Published var lastUpdated: Date?

    // Update this URL after deploying to Render
    private let apiURL = "https://c-train-delays-app.onrender.com"
    private var lastNotifiedStatus: TrainStatus?

    enum TrainStatus: Equatable {
        case loading
        case onTime
        case delayed
        case alert
        case error(String)

        var displayText: String {
            switch self {
            case .loading: return "Loading..."
            case .onTime: return "✓ On Time"
            case .delayed: return "⚠ Delayed"
            case .alert: return "⚠ Service Alert"
            case .error(let msg): return "Error: \(msg)"
            }
        }

        var emoji: String {
            switch self {
            case .onTime: return "✅"
            case .delayed: return "⏱️"
            case .alert: return "🚨"
            default: return "🚇"
            }
        }
    }

    func fetchStatus() {
        guard let url = URL(string: apiURL) else {
            currentStatus = .error("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    self.currentStatus = .error(error.localizedDescription)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.currentStatus = .error("No data received")
                }
                return
            }

            // The Flask app returns HTML, so we'll parse the status from the page
            // For now, let's just use a simple approach
            if let htmlString = String(data: data, encoding: .utf8) {
                let status = self.parseHTMLStatus(from: htmlString)

                DispatchQueue.main.async {
                    self.currentStatus = status
                    self.lastUpdated = Date()

                    // Send notification if status changed to delayed or alert
                    if status != self.lastNotifiedStatus {
                        if case .delayed = status {
                            self.sendNotification(title: "C Train Delayed", body: "The C Train is experiencing delays.")
                        } else if case .alert = status {
                            self.sendNotification(title: "C Train Alert", body: "There is a service alert for the C Train.")
                        }
                        self.lastNotifiedStatus = status
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.currentStatus = .error("Failed to parse response")
                }
            }
        }.resume()
    }

    private func parseHTMLStatus(from html: String) -> TrainStatus {
        let lowercased = html.lowercased()

        if lowercased.contains("service alert") || lowercased.contains("status-alert") {
            return .alert
        } else if lowercased.contains("delayed") || lowercased.contains("status-delayed") {
            return .delayed
        } else if lowercased.contains("on time") || lowercased.contains("status-on-time") {
            return .onTime
        }

        return .error("Unknown status")
    }


    private func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error)")
            }
        }
    }
}
