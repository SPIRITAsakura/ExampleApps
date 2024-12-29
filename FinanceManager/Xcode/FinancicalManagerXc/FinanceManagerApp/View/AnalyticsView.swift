import SwiftUI
import Charts

struct AnalyticsView: View {
    @EnvironmentObject var store: TransactionStore
    
    var categoryTotals: [(category: String, amount: Double)] {
        var totals: [String: Double] = [:]
        
        for transaction in store.transactions {
            if let category = transaction.category, !transaction.isIncome {
                totals[category] = (totals[category] ?? 0) + transaction.amount
            }
        }
        
        return totals.map { ($0.key, $0.value) }.sorted { $0.1 > $1.1 }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Расходы по категориям")) {
                    if !categoryTotals.isEmpty {
                        Chart(categoryTotals, id: \.category) { item in
                            SectorMark(
                                angle: .value("Сумма", item.amount),
                                innerRadius: .ratio(0.618)
                            )
                            .foregroundStyle(by: .value("Категория", item.category))
                        }
                        .frame(height: 200)
                    }
                    
                    ForEach(categoryTotals, id: \.category) { item in
                        HStack {
                            Text(item.category)
                            Spacer()
                            Text(String(format: "%.2f ₽", item.amount))
                        }
                    }
                }
            }
            .navigationTitle("Аналитика")
        }
    }
} 
