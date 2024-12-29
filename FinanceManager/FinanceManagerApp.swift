import SwiftUI
import CoreData

@main
struct FinanceManagerApp: App {
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var transactionStore = TransactionStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settingsStore)
                .environmentObject(transactionStore)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .preferredColorScheme(preferredColorScheme)
        }
    }
    
    private var preferredColorScheme: ColorScheme? {
        if settingsStore.useSystemTheme {
            return nil
        }
        return settingsStore.isDarkMode ? .dark : .light
    }
} 