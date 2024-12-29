import SwiftUI

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
