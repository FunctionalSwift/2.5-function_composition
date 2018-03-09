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

func formatPrice(price: Int) -> String {
    if price == 0 {
        return "Free"
    }
    else {
        return getFormatter(locale: Locale(identifier: "ES_es")).string(from: price as NSNumber)!
    }
}

func formatPrices(json: String) -> [String] {
    return formatAll(prices: getValidPrices(values: parse(json: json)))
}

func formatAll(prices: [Int]) -> [String] {
    return prices.map(formatPrice)
}

formatPrices(json: prices)
