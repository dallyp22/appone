import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = EggPriceViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Current Price Display
                PriceDisplayView(
                    price: viewModel.currentPrice,
                    isLoading: viewModel.isLoading,
                    errorMessage: viewModel.errorMessage
                )
                
                // Egg Visualization
                EggView(presidentImage: viewModel.presidentImage)
                
                // Historic Price Button
                NavigationLink(destination: HistoricPricesView()) {
                    Text("View Historic Prices")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Refresh Button
                Button(action: {
                    viewModel.fetchCurrentPrice()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Refresh")
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("US Egg Price Tracker")
        }
    }
}

#Preview {
    MainView()
} 