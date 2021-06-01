import Foundation

public class VaccineDataHandler { 
    public static func fetchVaccineDetails() -> [VaccineInformation] { 
        var toReturn: [VaccineInformation] = []
        do { 
            if let jsonPath = Bundle.main.path(forResource: "VaccineInfo", ofType: "json"), let jsonData = try String(contentsOfFile: jsonPath).data(using: .utf8), let vaccineData = try JSONDecoder().decode([VaccineInformation]?.self, from: jsonData) { 
                toReturn = vaccineData
            }
        } catch { 
            print(error)
        }
        return toReturn
    }
}
