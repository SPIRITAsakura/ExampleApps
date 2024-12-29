import SwiftUI

struct BudgetView: View {
    @EnvironmentObject var store: TransactionStore
    @State private var showingAddBudget = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.budgets, id: \.id) { budget in
                    BudgetRow(budget: budget, spent: calculateSpent(for: budget))
                }
            }
            .navigationTitle("Бюджет")
            .toolbar {
                Button(action: { showingAddBudget = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddBudget) {
                AddBudgetView()
            }
        }
    }
    
    private func calculateSpent(for budget: BudgetEntity) -> Double {
        store.transactions
            .filter { $0.category == budget.category && !$0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
}

struct BudgetRow: View {
    let budget: BudgetEntity
    let spent: Double
    
    var progress: Double {
        min(spent / budget.limit, 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(budget.category ?? "")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.0f%%", progress * 100))
                    .foregroundColor(progress > 0.9 ? .red : .primary)
            }
            
            ProgressView(value: progress)
                .tint(progress > 0.9 ? .red : .blue)
            
            HStack {
                Text(String(format: "%.2f ₽", spent))
                Text("/")
                Text(String(format: "%.2f ₽", budget.limit))
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
