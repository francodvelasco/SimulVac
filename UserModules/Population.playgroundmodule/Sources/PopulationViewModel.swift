import SwiftUI
import Vaccines

public class PopulationViewModel: ObservableObject { 
    @Published public var population: [Individual] = []
    @Published public var vaccineInfo: [VaccineInformation] =  VaccineDataHandler.fetchVaccineDetails().shuffled()
    @Published public var tick: Int = 0
    
    @Published public var popStatistics: [HealthStatus: [(Int, Int)]] = Dictionary(uniqueKeysWithValues: HealthStatus.allCases.lazy.map { status in 
        return (status, [])
    })
    
    public init(percentageVaccinated: Int) { 
        createPopulation(percentageVaccinated: percentageVaccinated)
    }
    
    public func reset() { 
        let personToInfect = Int.random(in: 1...100)
        population = population.map { i in
            i.healthStatus = i.id == personToInfect ? .asymptomatic : .uninfected
            i.worstHealthStatus = i.id == personToInfect ? .asymptomatic : .uninfected
            i.numberOfDaysInfected = 0
            i.isAlive = true
            return i
        }
        popStatistics = Dictionary(uniqueKeysWithValues: HealthStatus.allCases.lazy.map { status in 
            return (status, [])
        })
        tick = 0
    }
    
    public func changeVaccinatedPop(percentageVaccinated: Double, customPercentages: [(VaccineInformation, Double)]? = nil) { 
        createPopulation(percentageVaccinated: Int(percentageVaccinated), customPercentages: customPercentages)
        popStatistics = Dictionary(uniqueKeysWithValues: HealthStatus.allCases.lazy.map { status in 
            return (status, [])
        })
        tick = 0
    }
    
    public func createPopulation(percentageVaccinated: Int, customPercentages: [(VaccineInformation, Double)]? = nil) { 
        let group = DispatchGroup()
        DispatchQueue.global(qos: .userInitiated).sync { [self] in 
            group.enter()
            let listVaccinated = makeRandomList(length: percentageVaccinated)
            var shuffledVaccines = vaccineInfo.map { $0 }
            var vaccineBrands: [Int: VaccineInformation] = [:]
            if percentageVaccinated > 0 { 
                var vaccineNumbers: [VaccineInformation: Int] = [:]
                if let custom = customPercentages { 
                    vaccineNumbers = Dictionary(uniqueKeysWithValues: custom.lazy.map { vaccine in
                        (vaccine.0, Int(Double(percentageVaccinated) * vaccine.1 / 100))
                    })
                } else { 
                    vaccineNumbers = Dictionary(uniqueKeysWithValues: vaccineInfo.lazy.map { vaccine in
                        (vaccine, Int(Double(percentageVaccinated) * Double(vaccine.percentageWithThisVaccine) / 100.0))
                    })
                }
            listVaccinated.forEach { id in
                    var vaccineToGive = vaccineNumbers.randomElement()?.key
                    if let vaccine = vaccineToGive, vaccineNumbers[vaccine] == 0 { 
                        vaccineToGive = vaccineNumbers.randomElement()?.key
                    } else if let vaccine = vaccineToGive { 
                        vaccineBrands[id] = vaccine
                        vaccineNumbers[vaccine] = vaccineNumbers[vaccine] ?? 0 - 1
                    }
                }
            }
            let listWithComobidities: [Int] = makeRandomList(length: 20)
            let personToInfect = Int.random(in: 1...100)
            population = (1...100).map { count in
                return Individual(id: count, isVaccinated:  listVaccinated.contains(count), vaccineBrand: vaccineBrands[count], hasComorbidity: listWithComobidities.contains(count), infect: personToInfect == count)
            }
            group.leave()
        }
    }
    
    public func runSim() { 
        let group = DispatchGroup()
        var newPop: [Individual] = population.map { $0 }
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            population = newPop.map { individual in
                group.enter()
                if individual.healthStatus == .asymptomatic || individual.healthStatus == .mild || individual.healthStatus == .severe { 
                    //infect those immediately near the circle
                    let idOfPersonsToInfect: [Int] = [individual.id - 11, individual.id - 10, individual.id - 9, individual.id - 1, individual.id + 1, individual.id + 9, individual.id + 10, individual.id + 11]
                    var possiblePeopleToInfect: [Individual] = idOfPersonsToInfect.filter { idToFilter in 
                        (population.indices.contains(idToFilter) && returnFilterModuloList(num: individual.id).contains(idToFilter % 10)) 
                    }.map { id in return newPop[id] }
                    var numberOfPeopleToInfect = Int.random(in: 1...4) //simulate r-naught of covid-19, estimated at 2.4 - 3.4 but varies by a whole host of conditions
                    let idToInfect = possiblePeopleToInfect.indices.randomElement()!
                    if possiblePeopleToInfect[idToInfect].healthStatus == .uninfected {
                        possiblePeopleToInfect[idToInfect].infectPerson()
                        possiblePeopleToInfect.remove(at: idToInfect)
                    }
                }
                individual.runThroughDay()
                group.leave()
                group.wait()
                return individual
            }
        }
        for status in HealthStatus.allCases { 
            let count = population.filter({ i in return i.healthStatus == status}).count
            popStatistics[status]?.append((tick, count))
        }
    }
    
    func makeRandomList(length: Int) -> [Int] { 
        if length > 0 { 
            return (1...length).map { _ in
                .random(in: 1...100)
            }
        }
        return []
    }
    
    func returnFilterModuloList(num: Int) -> [Int] { 
        var listToReturn: [Int] = [num % 10]
        if num % 10 != 1 { 
            listToReturn.append((num - 1) % 10)
        }
        if num % 10 != 0 { 
            listToReturn.append((num + 1) % 10)
        }
        return listToReturn
    }
}

