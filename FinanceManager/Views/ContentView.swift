import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var store: TransactionStore
    
    var body: some View {
        TabView {
            TransactionsView()
                .tabItem {
                    Label("Транзакции", systemImage: "list.bullet")
                }
            
            AnalyticsView()
                .tabItem {
                    Label("Аналитика", systemImage: "chart.pie")
                }
            
            BudgetView()
                .tabItem {
                    Label("Бюджет", systemImage: "banknote")
                }
            
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TransactionStore())
    }
} 