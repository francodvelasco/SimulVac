import SwiftUI

public struct VaccineView: View { 
    let vaccine: VaccineInformation
    
    public init(vaccine: VaccineInformation) { 
        self.vaccine = vaccine
    }
    
    public var body: some View { 
        GeometryReader { g in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1, height: g.size.height) 
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 20)
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1, height: g.size.height) 
                Rectangle().fill(Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255).opacity(0.7))
                    .border(Color.gray, width: 2)
                        .overlay(
                            VStack {
                                HStack { 
                                    VStack(alignment: .leading) { 
                                        Text(vaccine.vaccine)
                                            .foregroundColor(Color.black)
                                            .font(.title2)
                                        Text(vaccine.manufacturer)
                                            .foregroundColor(Color.gray)
                                            .font(.headline)
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing){ 
                                        Text(vaccine.dosageInfo)
                                        Text(vaccine.countryOfOrigin)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                                .padding([.top, .horizontal], 4)
                                Spacer()
                            }
                            .background(Color(red: 135 / 255, green: 206 / 255, blue: 1).opacity(0.5))
                            .padding(.horizontal))
                Rectangle()
                    .frame(width: 20, height: 30)
            }
        }
        .frame(width: 300, height: 50)
    }
}
