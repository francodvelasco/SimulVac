import SwiftUI
import Resources

public struct PopulationView: View {
    @ObservedObject var viewModel: PopulationViewModel
    
    public init(viewModel: ObservedObject<PopulationViewModel>) { 
        self._viewModel = viewModel
    }
    
    public init(percentageVaccinated: Int) { 
        self.viewModel = PopulationViewModel(percentageVaccinated: percentageVaccinated)
    }
    
    public var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 10)) {
                ForEach(viewModel.population.indices, id: \.self) { i in
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 3)
                        .background(Circle().foregroundColor(viewModel.population[i].healthStatus.color()))
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(6)
        .background(Color.backgroundColor)
        .cornerRadius(7.5)
    }
}
