//: Playground - Function Composition

import Foundation

let prices = "[\"10\", \"5\", \"null\", \"20\", \"0\"]"

infix operator |>: AdditionPrecedence

func |><T, U, V>(_ firstStep: @escaping (T) -> U, _ secondStep: @escaping (U) -> V) -> (T) -> V {
    return { t in
        secondStep(firstStep(t))
    }
}

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

func formatPrice(locale: Locale) -> (Int) -> String {
    return  { price in
        if price == 0 {
            return "Free"
        }
        else {
            return getFormatter(locale: locale).string(from: price as NSNumber)!
        }
    }
}

func formatAll(locale: Locale) -> ([Int]) -> [String] {
    return {
        $0.map(formatPrice(locale: locale))
    }
}

let formatAllEuro = formatAll(locale: Locale(identifier: "ES_es"))

let formatPrices = parse |> getValidPrices |> formatAllEuro

formatPrices(prices)

