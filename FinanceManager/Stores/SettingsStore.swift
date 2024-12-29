import SwiftUI

class SettingsStore: ObservableObject {
    @AppStorage("isDarkMode") private(set) var isDarkMode = false
    @AppStorage("useSystemTheme") private(set) var useSystemTheme = true
    @AppStorage("currencyCode") private(set) var currencyCode = "RUB"
    
    let availableCurrencies = [
        "RUB": "₽",
        "USD": "$",
        "EUR": "€",
        "GBP": "£"
    ]
    
    func setCurrency(_ code: String) {
        currencyCode = code
    }
    
    
}

class SettingsStore: ObservableObject {
    @AppStorage("isDarkMode") private(set) var isDarkMode = false
    @AppStorage("useSystemTheme") private(set) var useSystemTheme = true
    
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
    
    func toggleSystemTheme() {
        useSystemTheme.toggle()
    }
} 