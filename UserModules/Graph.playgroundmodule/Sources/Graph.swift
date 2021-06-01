import SwiftUI
import Population
import Resources

public struct LineGraphView: View { 
    @ObservedObject var popViewModel: PopulationViewModel
    var maxDimensions: (height: CGFloat, width: CGFloat) = (400, 568)
    
    public init(popViewModel: ObservedObject<PopulationViewModel>) { 
        self._popViewModel = popViewModel
    }
    
    public var body: some View { 
        VStack {
            ZStack { 
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(8)
            
                VStack { 
                    ZStack {
                        ForEach(HealthStatus.allCases, id: \.self) { status in
                            if let statistics = popViewModel.popStatistics[status], statistics.count >= 2 { 
                                createGraph(plotPoints: statistics)
                                    .stroke(status.color(), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            }
                        }
                    }
                }
                .padding()
                .frame(width: maxDimensions.width, height: maxDimensions.height)
            }
            LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 2)) { 
                ForEach(HealthStatus.allCases, id: \.self) { status in
                    HStack { 
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 1.5)
                            .background(Circle().foregroundColor(status.color()))
                            .frame(width: 10, height: 10)
                        Text("\(status.desc()): \(popViewModel.popStatistics[status]?.last?.1 ?? 0)%")
                            .foregroundColor(Color.black)
                    }
                }
            }
            .frame(height: 50)
        }
        .frame(width: maxDimensions.width, height: maxDimensions.height + 50)
        .cornerRadius(8)
    }
    
    func createGraph(plotPoints: [(day: Int, count: Int)]) -> Path { 
        var path = Path()
        path.move(to: CGPoint(x: 0, y: (maxDimensions.height - 30) * CGFloat(1 - Double((plotPoints.first?.count ?? 100) / 100))))
        for (x, y) in plotPoints[1...] {
            let xComponent = maxDimensions.width * CGFloat(x) / 30
            let yComponent = (maxDimensions.height - 30) * (1 - CGFloat(y) / 100)
            path.addLine(to: CGPoint(x: xComponent, y: yComponent))
        }
        return path
    }
}

