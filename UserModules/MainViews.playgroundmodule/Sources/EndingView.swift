import SwiftUI
import Foundation
import Resources
import PlaygroundSupport

public struct EndingView: View {
    @State var showMaskUp = false
    @State var showGetShot = false
    @State var showSaveLives = false
    @State var showButton = false
    
    public init() { 
        
    }
    
    public var body: some View {
        VStack {
            Spacer()
            Text("See the difference getting the shot makes?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            GeometryReader { g in
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("0% Vaccinated")
                        Text("Infected: 89-97%")
                        Text("Died: 9-16%")
                    }
                    .padding(15)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("21% Vaccinated")
                        Text("Infected: 83-97%")
                        Text("Died: 5-9%")
                    }
                    .padding(15)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("100% Vaccinated")
                        Text("Infected: 1-32%")
                        Text("Died: 0-1%")
                    }
                    .padding(15)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                    Spacer()
                }
                .font(.title3)
            }
            .frame(width: 600, height: 100)
            Text("Collated data from multiple trials of each scenario.")
                .font(.caption)
                .padding(.bottom)
            Text("This vaccine is safe, effective, and proven to save your life -- and countless others.")
                .font(.title3)
            Spacer().frame(height: 15)
            HStack {
                if showMaskUp {
                    Text("Mask up.")
                }
                if showGetShot {
                    Text("Get the Shot.")
                }
                if showSaveLives {
                    Text("Save lives.")
                        .fontWeight(.semibold)
                }
            }
            .font(.title3)
            Spacer().frame(height: 25)
            if showButton {
                Button(action: {
                    PlaygroundPage.current.navigateTo(page: .next)
                }) {
                    HStack {
                        Text("Customize the Simulation")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            Spacer()
        }
        .background(Color.white)
        .frame(width: 600, height: 600)
        .foregroundColor(Color.black)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.showMaskUp = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.showGetShot = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                self.showSaveLives = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
                self.showButton = true
            }
        }
    }
}
