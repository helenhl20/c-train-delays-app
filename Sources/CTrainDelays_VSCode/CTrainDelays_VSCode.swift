import SwiftUI

@main
struct CTrainDelaysApp: App {
    @StateObject private var fetcher = CStatusFetcher()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fetcher)
                .onAppear {
                    fetcher.fetch()
                }
        }
    }
}

class CStatusFetcher: ObservableObject {
    @Published var status = "Loading..."

    func fetch() {
        guard let url = URL(string: "http://127.0.0.1:5000/c_status") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
                  let state = json["status"] else { return }
            DispatchQueue.main.async {
                self.status = state.capitalized
            }
        }.resume()
    }
}

struct ContentView: View {
    @EnvironmentObject var fetcher: CStatusFetcher

    var body: some View {
        VStack(spacing: 20) {
            Text("🚇 C Train Status")
                .font(.largeTitle)
            Text(fetcher.status)
                .font(.title)
                .foregroundColor(fetcher.status == "Delayed" ? .red : .green)
        }
        .padding()
    }
}

