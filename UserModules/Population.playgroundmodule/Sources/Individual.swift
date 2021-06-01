import SwiftUI
import Vaccines

public class Individual { 
    public var id: Int
    public var isAlive: Bool
    
    public var isVaccinated: Bool
    public var vaccineBrand: VaccineInformation?
    
    public var healthStatus: HealthStatus
    public var numberOfDaysInfected: Int?
    var worstHealthStatus: HealthStatus
    
    public var hasComorbidity: Bool
    
    public init(id: Int, hasComorbidity: Bool) { 
        self.id = id
        self.isAlive = true
        self.isVaccinated = false
        self.healthStatus = id == 1 ? .asymptomatic : .uninfected
        self.hasComorbidity = hasComorbidity
        self.worstHealthStatus = id == 1 ? .asymptomatic : .uninfected
    }
    
    public init(id: Int, isVaccinated: Bool, vaccineBrand: VaccineInformation?, hasComorbidity: Bool, infect: Bool = false) { 
        self.id = id
        self.isAlive = true
        
        self.isVaccinated = isVaccinated
        self.vaccineBrand = vaccineBrand
        
        self.healthStatus = infect ? .asymptomatic : .uninfected
        self.hasComorbidity = hasComorbidity
        self.worstHealthStatus = infect ? .asymptomatic : .uninfected
    }
    
    public func infectPerson() { 
        if healthStatus == .uninfected {
            self.numberOfDaysInfected = 1
            self.healthStatus = .asymptomatic
        }
    }
    
    public func runThroughDay() { 
        var probability = Double.random(in: 1...100) + (hasComorbidity ? 15 : 0) - Double((numberOfDaysInfected ?? 0) * 1)
        if healthStatus == .asymptomatic { 
            probability -= probability * (vaccineBrand?.mildEfficacyRate ?? 0 / 100)
            if probability > 86 && worstHealthStatus.rawValue <= HealthStatus.mild.rawValue { //value from https://www.japantimes.co.jp/news/2020/06/15/national/science-health/asymptomatic-covid-19-patients/
                healthStatus = .mild
                worstHealthStatus = .mild
            } else if probability < 30  { 
                healthStatus = .recovered
                return
            }
            numberOfDaysInfected = numberOfDaysInfected ?? 0 + 1
        } else if healthStatus == .mild { 
            probability -= probability * (vaccineBrand?.severeEfficacyRate ?? 0 / 100)
            if probability > 79 && worstHealthStatus.rawValue <= HealthStatus.severe.rawValue {  //value from https://translational-medicine.biomedcentral.com/articles/10.1186/s12967-020-02423-8
                healthStatus = .severe
                worstHealthStatus = .severe
            } else if probability < 40 { 
                healthStatus = .asymptomatic
            }
            numberOfDaysInfected = numberOfDaysInfected ?? 0 + 1
        } else if healthStatus == .severe { //value from https://care.diabetesjournals.org/content/43/7/1378
            if probability - probability * (vaccineBrand?.deathEfficacyRate ?? 0 / 100) > 83.6 { 
                healthStatus = .dead
                worstHealthStatus = .dead
                return
            } else if probability < 43 { 
                healthStatus = .mild
            }
            numberOfDaysInfected = numberOfDaysInfected ?? 0 + 1
        }
    }
}

public enum HealthStatus: Int, CaseIterable { 
    case uninfected = 0, asymptomatic, mild, severe, dead, recovered
    
    public func color() -> Color { 
        switch self { 
        case .uninfected:
            return Color.white
        case .asymptomatic:
            return Color.yellow
        case .mild:
            return Color.orange
        case .severe:
            return Color.red
        case .dead:
            return Color.black
        case .recovered:
            return Color.green
        }
    }
    
    public func desc() -> String { 
        switch self { 
        case .uninfected:
            return "Uninfected"
        case .asymptomatic:
            return "Asymptomatic"
        case .mild:
            return "Mild Case"
        case .severe:
            return "Severe Case"
        case .dead:
            return "Dead"
        case .recovered:
            return "Recovered"
        }
    }
}
