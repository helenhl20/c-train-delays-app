import SwiftUI

struct ContentView: View {
    @EnvironmentObject var statusManager: CTrainStatusManager

    var body: some View {
        ZStack {
            // MTA Blue background
            Color(red: 0, green: 0.224, blue: 0.651)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                // Train icon
                Text("🚇")
                    .font(.system(size: 80))

                // Title
                Text("C Train Status")
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .foregroundColor(.white)

                // Status card
                VStack(spacing: 20) {
                    statusBadge

                    statusMessage

                    if let lastUpdated = statusManager.lastUpdated {
                        Text("Last updated: \(lastUpdated, style: .time)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(40)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding(.horizontal, 30)

                // Refresh button
                Button(action: {
                    statusManager.fetchStatus()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Refresh")
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(25)
                }
                .padding(.top, 20)

                Spacer()
            }
        }
        .font(.custom("Helvetica", size: 17))
    }

    @ViewBuilder
    private var statusBadge: some View {
        switch statusManager.currentStatus {
        case .onTime:
            Text("✓ ON TIME")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.086, green: 0.396, blue: 0.204))
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color(red: 0.290, green: 0.867, blue: 0.502))
                .cornerRadius(25)
        case .delayed:
            Text("⚠ DELAYED")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.471, green: 0.208, blue: 0.059))
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color(red: 0.984, green: 0.749, blue: 0.141))
                .cornerRadius(25)
        case .alert:
            Text("⚠ SERVICE ALERT")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.498, green: 0.114, blue: 0.114))
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color(red: 0.973, green: 0.443, blue: 0.443))
                .cornerRadius(25)
        case .loading:
            ProgressView()
                .scaleEffect(1.5)
        case .error:
            Text("❌ ERROR")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.red)
        }
    }

    @ViewBuilder
    private var statusMessage: some View {
        switch statusManager.currentStatus {
        case .onTime:
            Text("All systems running smoothly! The C Train is operating on schedule.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        case .delayed:
            Text("The C Train is experiencing delays. Please allow extra travel time.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        case .alert:
            Text("There are active service alerts for the C Train. Check MTA for details.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        case .loading:
            Text("Checking train status...")
                .foregroundColor(.gray)
        case .error(let message):
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
        }
    }
}
