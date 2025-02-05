import SwiftUI
import Combine

struct PriceResponse: Codable {
    let price: Double
    let timestamp: String
    let currency: String
}

class EggPriceViewModel: ObservableObject {
    @Published var currentPrice: Double = 0.0
    @Published var presidentImage: Image = Image("eggp") // Changed from "biden" to "eggp"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "http://localhost:8000"
    
    init() {
        fetchCurrentPrice()
    }
    
    func fetchCurrentPrice() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "\(baseURL)/api/current-price") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PriceResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.currentPrice = response.price
            }
            .store(in: &cancellables)
    }
} 