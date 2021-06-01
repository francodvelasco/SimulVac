import SwiftUI
import Resources

public struct VaccineDetailedView: View { 
    @Binding var showView: Bool
    let vaccine: VaccineInformation
    
    public init(showView: Binding<Bool>, vaccine: VaccineInformation) { 
        self._showView = showView
        self.vaccine = vaccine
    }
    
    public var body: some View { 
        VStack(alignment: .leading, spacing: 1) { 
            Spacer()
                .frame(height: 10)
            HStack { 
                Spacer()
                VaccineView(vaccine: vaccine)
                Spacer()
            }
            Spacer()
                .frame(height: 10)
            Text("Efficacy Rates")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.medium)
                .padding(.leading)
            HStack { 
                VStack(alignment: .leading) { 
                    Text("Against Mild Cases")
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer().frame(height: 15)
                    Text("\(Int(vaccine.mildEfficacyRate))%")
                        .font(.largeTitle)
                }
                .font(.title2)
                .padding(8)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.backgroundColor)
                .cornerRadius(8)
                
                VStack(alignment: .leading) { 
                    Text("Against Severe Cases")
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer().frame(height: 15)
                    Text("\(Int(vaccine.severeEfficacyRate))%")
                        .font(.largeTitle)
                }
                .font(.title2)
                .padding(8)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.backgroundColor)
                .cornerRadius(8)
                
                VStack(alignment: .leading) { 
                    Text("Against Death")
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer().frame(height: 15)
                    Text("\(Int(vaccine.deathEfficacyRate))%")
                        .font(.largeTitle)
                }
                .font(.title2)
                .padding(8)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.backgroundColor)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            Spacer()
                .frame(height: 10)
            Text("More about \(vaccine.manufacturer)'s vaccine")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.medium)
                .padding(.leading)
            VStack(alignment: .leading) { 
                if let WHOurl = URL(string: vaccine.WHOInfo) { 
                    Link(destination: WHOurl) { 
                        HStack { 
                            Spacer()
                            Text("World Health Organization (WHO)")
                            Spacer()
                        }
                        .padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
                if let CDCurl = URL(string: vaccine.CDCInfo) { 
                    Link(destination: CDCurl) { 
                        HStack { 
                            Spacer()
                            Text("US Center for Disease Control (CDC)")
                            Spacer()
                        }
                        .padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
                if let FDAurl = URL(string: vaccine.FDAInfo) { 
                    Link(destination: FDAurl) { 
                        HStack { 
                            Spacer()
                            Text("US Food and Drug Administration (FDA)")
                            Spacer()
                        }
                        .padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
            HStack { 
                Spacer()
                Button(action: { 
                    self.showView = false
                }) { 
                    HStack { 
                        Text("Go Back")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.uturn.left")
                    }
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding(.vertical)
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .frame(width: 500)
        .cornerRadius(8)
    }
}
