import SwiftUI
import Population
import Graph
import Vaccines

public struct CustomSimView: View { 
    @ObservedObject var popViewModel: PopulationViewModel
    @State var percentageVaccinated: Double = 0
    
    @State var vaccinePercentages: [(vaccine: VaccineInformation, percentage: Double)] = VaccineDataHandler.fetchVaccineDetails().map { vaccine in return (vaccine,  Double(vaccine.percentageWithThisVaccine)) }
    
    @State var showVaccineDetails = false
    @State var vaccineDetails: VaccineInformation? = nil
    
    var unallocatedVaccinePercentage: Double { 
        return 100 - vaccinePercentages.map { vaccine in
            vaccine.percentage
        }.reduce(0, +)
    }
    
    @State var timer = Timer.publish(every: 1, on: .current, in: .common)
    
    public init(percentageVaccinated: Int) { 
        self.popViewModel = PopulationViewModel(percentageVaccinated: percentageVaccinated)
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
                VStack(spacing: 1) { 
                    HStack { 
                        Text("Percentage Vaccinated")
                        Spacer()
                        Text("\(Int(percentageVaccinated))%")
                    }
                    .font(.title3)
                    Slider(value: $percentageVaccinated, in: 0.0...100.0, step: 1.0)
                }
                .padding()
                .background(Color.backgroundColor)
                .cornerRadius(8)
                .padding([.horizontal])
                .padding(.bottom, 8)
                .foregroundColor(.black)
                
                HStack { 
                    VStack(spacing: 1)  { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[0].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("Pfizer")
                            Spacer()
                            Text("\(Int(vaccinePercentages[0].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[0].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    
                    VStack(spacing: 1)  { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[1].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("Moderna")
                            Spacer()
                            Text("\(Int(vaccinePercentages[1].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[1].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    
                    
                    VStack(spacing: 1)  { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[2].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("J&J")
                            Spacer()
                            Text("\(Int(vaccinePercentages[2].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[2].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    
                    VStack(spacing: 1)  { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[3].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("Sputnik V")
                            Spacer()
                            Text("\(Int(vaccinePercentages[3].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[3].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                }
                .padding([.horizontal])
                .padding(.bottom, 8)
                .foregroundColor(.black)
                .font(.title3)
                
                HStack { 
                    VStack(spacing: 1) { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[4].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("Novavax")
                            Spacer()
                            Text("\(Int(vaccinePercentages[4].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[4].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    
                    VStack(spacing: 1) { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[5].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("Oxford")
                            Spacer()
                            Text("\(Int(vaccinePercentages[5].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[5].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    
                    VStack(spacing: 1) { 
                        HStack(spacing: 1) { 
                            Button(action: { 
                                self.showVaccineDetails = true
                                self.vaccineDetails = vaccinePercentages[6].vaccine
                            }) { 
                                Image(systemName: "info.circle")
                            }
                            .foregroundColor(.blue)
                            Text("Sinovac")
                            Spacer()
                            Text("\(Int(vaccinePercentages[6].percentage))%")
                        }
                        Slider(value: $vaccinePercentages[6].percentage, in: 0.0...100.0, step: 1.0)
                    }
                    .padding(6)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 1) { 
                        HStack { 
                            Text("Unallocated")
                            Spacer()
                        }
                        Spacer().frame(height: 10)
                        Text("\(Int(self.unallocatedVaccinePercentage))%")
                    }
                    .padding(8)
                    .foregroundColor(unallocatedVaccinePercentage != 0 ? Color.red : .black)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                }
                .padding([.horizontal])
                .padding(.bottom, 8)
                .foregroundColor(.black)
                .font(.title3)
                
                HStack { 
                    Button(action: { 
                        popViewModel.changeVaccinatedPop(percentageVaccinated: percentageVaccinated, customPercentages: vaccinePercentages)
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
                    .disabled(unallocatedVaccinePercentage != 0)
                    Spacer()
                }
            }
            .background(Color.white)
            .frame(width: 600, height: 800)
            .onReceive(timer) { _ in
                popViewModel.runSim()
                popViewModel.tick += 1
                if popViewModel.tick == 30 { 
                    timer.connect().cancel()
                }
            }
            
            if let vaccine = vaccineDetails, showVaccineDetails { 
                Color.black
                    .opacity(0.5)
                    .blur(radius: 1)
                    .frame(width: 600)
                    .animation(.default)
                VaccineDetailedView(showView: $showVaccineDetails, vaccine: vaccine)
                    .animation(.default)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

