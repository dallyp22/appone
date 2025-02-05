import Foundation
import Combine

struct HistoricPriceResponse: Codable {
    let date: String
    let price: Double
    let currency: String
}

struct PriceData: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

class HistoricPricesViewModel: ObservableObject {
    @Published var historicPrices: [PriceData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "http://localhost:8000"
    
    init() {
        fetchHistoricPrices()
    }
    
    func fetchHistoricPrices() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "\(baseURL)/api/historic-prices") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [HistoricPriceResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                let dateFormatter = ISO8601DateFormatter()
                self?.historicPrices = response.compactMap { item in
                    guard let date = dateFormatter.date(from: item.date) else { return nil }
                    return PriceData(date: date, price: item.price)
                }.sorted { $0.date > $1.date }
            }
            .store(in: &cancellables)
    }
} 