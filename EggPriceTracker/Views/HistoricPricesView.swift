import SwiftUI
import Charts

struct HistoricPricesView: View {
    @StateObject private var viewModel = HistoricPricesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading price history...")
                    .scaleEffect(1.5)
                    .padding()
            } else if let error = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else {
                Chart {
                    ForEach(viewModel.historicPrices) { price in
                        LineMark(
                            x: .value("Date", price.date),
                            y: .value("Price", price.price)
                        )
                        .foregroundStyle(.green)
                        
                        PointMark(
                            x: .value("Date", price.date),
                            y: .value("Price", price.price)
                        )
                        .foregroundStyle(.green)
                    }
                }
                .frame(height: 300)
                .padding()
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 7)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel {
                                Text(date.formatted(.dateTime.month().day()))
                                    .rotationEffect(.degrees(-45))
                            }
                        }
                    }
                }
                
                List(viewModel.historicPrices) { price in
                    HStack {
                        Text(price.date.formatted(date: .abbreviated, time: .omitted))
                        Spacer()
                        Text("$\(String(format: "%.2f", price.price))")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
            }
        }
        .navigationTitle("Historic Egg Prices")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.fetchHistoricPrices()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                .disabled(viewModel.isLoading)
            }
        }
    }
}

#Preview {
    NavigationView {
        HistoricPricesView()
    }
} 