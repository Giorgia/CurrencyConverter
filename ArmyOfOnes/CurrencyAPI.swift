//
//  CurrencyAPI.swift
//  ArmyOfOnes
//
//  Created by Giorgia Marenda on 10/26/15.
//  Copyright © 2015 Giorgia Marenda. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum Currency: Int {
    case US, UK, EU, JP, BS
    
    var standardDesc: String {
         switch self {
         case .US: return "USD"
         case .UK: return "GBP"
         case .EU: return "EUR"
         case .JP: return "JPY"
         case .BS: return "BRL"
        }
    }
    var flag: String {
        switch self {
        case .US: return "🇱🇷"
        case .UK: return "🇬🇧"
        case .EU: return "🇪🇺"
        case .JP: return "🇯🇵"
        case .BS: return "🇧🇷"
        }
    }
    
    static let allValues = [US, UK, EU, JP, BS]
}

let baseURL = "https://currency-api.appspot.com"

class CurrencyAPI {
    
    /**
     Performs the GET request at Currency API
     */
    class func convertion(from source: Currency, to target: Currency, amount: Int, completion: (Conversion?, ErrorType?) -> Void) {
        let currencyPath = baseURL + "/api/\(source.standardDesc)/\(target.standardDesc).json"
       
        Alamofire.request(.GET, currencyPath, parameters: ["amount": amount])
            .responseObject { (conversion: Conversion?, error) -> Void in
                
                if let c = conversion, m = c.message where !c.success {
                   completion(c, Error.errorWithCode(1000, failureReason: m))
                }
                completion(conversion, error)
        }
    }
}

class Conversion: Mappable {
    var amount:     Double?
    var rate:       Double?
    var source:     String?
    var target:     String?
    
    var success:    Bool = false
    var message:    String?
    
    required init?(_ map: Map){
    }
    
    func mapping(map: Map) {
        amount      <- map["amount"]
        rate        <- map["rate"]
        source      <- map["source"]
        target      <- map["target"]
        success     <- map["success"]
        message     <- map["message"]
    }
}