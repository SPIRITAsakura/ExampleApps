import SwiftUI

struct TransactionsView: View {
    @EnvironmentObject var store: TransactionStore
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.transactions, id: \.id) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
            .navigationTitle("Транзакции")
            .toolbar {
                Button(action: { showingAddTransaction = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView()
            }
        }
    }
}

struct TransactionRow: View {
    let transaction: TransactionEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.category ?? "")
                    .font(.headline)
                if let note = transaction.note {
                    Text(note)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Text(String(format: "%.2f ₽", transaction.amount))
                .foregroundColor(transaction.isIncome ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}
