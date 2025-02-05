import SwiftUI

struct EggView: View {
    let presidentImage: Image
    
    var body: some View {
        ZStack {
            // Egg shape
            EggShape()
                .fill(Color.white)
                .shadow(radius: 10)
                .frame(width: 200, height: 280)
            
            // President image inside egg
            presidentImage
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
        }
    }
}

struct EggShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addEllipse(in: CGRect(x: rect.minX,
                                  y: rect.minY,
                                  width: rect.width,
                                  height: rect.height * 0.8))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                         control: CGPoint(x: rect.maxX, y: rect.height * 0.8))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.height * 0.8),
                         control: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path
    }
} 