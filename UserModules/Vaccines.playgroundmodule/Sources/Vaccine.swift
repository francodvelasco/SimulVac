import Foundation

public struct VaccineInformation: Decodable, Hashable { 
    public var vaccine: String
    public var manufacturer: String
    public var countryOfOrigin: String
    public var dosageInfo: String
    
    public var deathEfficacyRate: Double
    public var severeEfficacyRate: Double
    public var mildEfficacyRate: Double
    
    public var WHOInfo: String
    public var FDAInfo: String
    public var CDCInfo: String
    
    public var percentageWithThisVaccine: Int
}
