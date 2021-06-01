import SwiftUI
import PlaygroundSupport
import Resources

public struct IntroductionView: View { 
    @State var percentage: Int = Int.random(in: 0...100)
    @State var showButton = false
    @State var numberOfFires = 0
    
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    public init() { 
    }
    
    public var body: some View { 
        VStack(alignment: .leading){ 
            VStack(alignment: .leading) { 
                Text("What if only ") + 
                    Text("\(percentage)%").fontWeight(.semibold) +
                    Text(" of the population")
                Text("got vaccinated against") +
                    Text(" COVID-19?")
                    .fontWeight(.semibold)
            }
            .font(.largeTitle)
            Spacer()
                .frame(height: 50)
            Text("Vaccine hesitancy is on the rise.\nWhat effect could that bring on our quest\nto beat the pandemic?")
                .font(.title)
            Spacer()
                .frame(height: 50)
            if showButton {
                Button(action: { 
                    PlaygroundPage.current.navigateTo(page: .next)
                }) { 
                    HStack { 
                        Text("See")
                        Image(systemName: "arrow.forward")
                    }
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .cornerRadius(7.5)
                }
            }
        }
        .frame(width: 600, height: 800)
        .background(Color.backgroundColor)
        .foregroundColor(.black)
        .onReceive(timer) { _ in
            withAnimation {
                self.percentage = Int.random(in: 0...100)
            }
            numberOfFires += 1
            DispatchQueue.main.async {
                if numberOfFires == 10 { 
                    withAnimation {
                        showButton = true
                    }
                }
            }
            if numberOfFires == 15 { 
                timer.upstream.connect().cancel()
            }
        }
    }
}

