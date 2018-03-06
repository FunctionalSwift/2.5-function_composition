//: Playground - Function Composition

import Foundation

let prices = "[\"10\", \"5\", \"null\", \"20\", \"0\"]"

func parse(json: String) -> [String] {
    let data = json.data(using: .utf8)!
    
    return try! JSONSerialization.jsonObject(with: data) as! [String]
}

func getValidPrices(values: [String]) -> [Int] {
    return values
        .map { Int($0) }
        .filter { $0 != nil }
        .map { $0! }
}

func getFormatter(locale: Locale) -> NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = locale
    
    return numberFormatter;
}

func formatPrice(locale: Locale, price: Int) -> String {
    if price == 0 {
        return "Free"
    }
    else {
        return getFormatter(locale: locale).string(from: price as NSNumber)!
    }
}

func formatPrices(json: String) -> [String] {
    let jsonArray = parse(json: json)
    let prices = getValidPrices(values: jsonArray)
    
    var labels = [String]()
    
    for price in prices {
        labels.append(formatPrice(locale: Locale(identifier:"ES_es"), price: price))
    }
    
    return labels
}

formatPrices(json: prices)
