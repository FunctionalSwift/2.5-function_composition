//: Playground - Function Composition

import Foundation

let prices = "[\"10\", \"5\", \"null\", \"20\", \"0\"]"

func formatPrices(json: String) -> [String] {
    let data = json.data(using: .utf8)!
    let jsonArray = try! JSONSerialization.jsonObject(with: data) as! [String]
    
    var labels = [String]()
    
    for element in jsonArray {
        let price = Int(element)
        
        if let price = price {
            var label = ""
            
            if price == 0 {
                label = "Free"
            }
            else {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = Locale(identifier: "ES_es")
                
                label = numberFormatter.string(from: price as NSNumber)!
            }
            
            labels.append(label)
        }
    }
    return labels
}

formatPrices(json: prices)
