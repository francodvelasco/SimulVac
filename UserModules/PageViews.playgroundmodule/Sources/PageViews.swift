import SwiftUI
import Population
import Graph
import PlaygroundSupport
import Resources

public struct MainPageViews: View { 
    @ObservedObject var popViewModel: PopulationViewModel
    @State var percentageVaccinated = 0
    @State var showNextPageButton: Bool = false
    @State var showInfoView: Bool = false
    @State var timer = Timer.publish(every: 1, on: .current, in: .common)
    
    public init(percentageVaccinated: Int) { 
        self.popViewModel = PopulationViewModel(percentageVaccinated: percentageVaccinated)
        self.percentageVaccinated = percentageVaccinated
    }
    
    public var body: some View { 
        ZStack { 
            VStack(alignment: .leading, spacing: 0) { 
                HStack { 
                    Text("Population")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Day \(popViewModel.tick)")
                        .font(.system(.title2, design: .rounded))
                }
                .foregroundColor(.black)
                .padding([.horizontal, .top])
                PopulationView(viewModel: self._popViewModel)
                    .padding([.horizontal, .bottom])
                
                Text("Graph")
                    .foregroundColor(.black)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.semibold)
                    .padding(.leading)
                LineGraphView(popViewModel: self._popViewModel)
                    .padding([.horizontal, .bottom])
                HStack { 
                    Button(action: { 
                        if showNextPageButton { 
                            //popViewModel.changeVaccinatedPop(percentageVaccinated: Double(percentageVaccinated))
                            popViewModel.reset()
                        }
                        timer = Timer.publish(every: 1, on: .current, in: .common)
                        timer.connect()
                    }) { 
                        HStack {
                            Text("Run Simulation")
                                .font(.title3)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    Spacer()
                    Button(action: { 
                        self.showInfoView = true
                    }) { 
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding([.trailing])
                    if showNextPageButton { 
                        Button(action: { 
                            PlaygroundPage.current.navigateTo(page: .next)
                        }) { 
                            HStack {
                                Text("Next Page")
                                Image(systemName: "arrow.right")
                            }
                            .font(.title3)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding()
                        }
                    }
                }
            }
            .background(Color.white)
            
            if showInfoView { 
                ZStack { 
                    Color.black
                        .opacity(0.5)
                        .frame(width: 600)
                        .blur(radius: 1)
                    VStack(alignment: .leading) { 
                        HStack { 
                            Image(systemName: "info.circle")
                            Text("About the Simulation")
                                .fontWeight(.semibold)
                            Spacer()
                            Button(action: { 
                                self.showInfoView = false
                            }) { 
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .font(.title)
                        Text("The ratio of vaccine brands administered to the people who were randomly selected to be vaccinated in the scenario were based off the vaccine orders by the Philippine government, determining how many people would be vaccinated by each brand, and getting its ratio against the total population of the Philippines. This turns out to 17% being administered Pfizer vaccines, 14% being administered Moderna, 7% Johnson & Johnson, 11% Sputnik V, 21% Novavax, 12% Oxford-AstraZeneca, and 18% Sinovac.\n")
                        Text("This simulation assumes 20% of people have comorbidities / underlying health conditions, reflecting the ratio of people with comorbidities in the Philippines. It also assumes that the complete dosage recommendation has been given to people (ie. 2 doses of Pfizer were given, or 1 dose of Johnson & Johnson), that the antibodies were already created by the body, and the efficacy rates against mild cases, severe cases, and death are similar to what is displayed from the vaccine’s respective clinical trials.\n")
                        Text("This simulation also assumes there are no intervention measures taken to slow the spread of COVID-19, including but not limited to mask mandates, social distancing mandates, lockdowns, and the like.\n")
                    }
                    .padding()
                    .frame(width: 500)
                    .foregroundColor(.black)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                }
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(width: 600, height: 800)
        .onReceive(timer) { _ in
            popViewModel.runSim()
            popViewModel.tick += 1
            if popViewModel.tick == 30 { 
                timer.connect().cancel()
                DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + .seconds(2)) { 
                    withAnimation { 
                        self.showNextPageButton = true
                    }
                }
            }
        }
    }
}

