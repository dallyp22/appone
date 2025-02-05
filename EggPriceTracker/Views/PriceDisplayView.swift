import SwiftUI

struct PriceDisplayView: View {
    let price: Double
    let isLoading: Bool
    let errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Current Price")
                .font(.headline)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            } else if let error = errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                Text("$\(String(format: "%.2f", price))")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.green)
                Text("per dozen")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .frame(height: 150)
    }
} 