import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: TransactionStore
    
    @State private var amount: String = ""
    @State private var category: Category = .other
    @State private var note: String = ""
    @State private var isIncome: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Детали транзакции")) {
                    TextField("Сумма", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Категория", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    TextField("Заметка", text: $note)
                    
                    Toggle("Доход", isOn: $isIncome)
                }
            }
            .navigationTitle("Новая транзакция")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        saveTransaction()
                    }
                }
            }
        }
    }
    
    private func saveTransaction() {
        guard let amountDouble = Double(amount) else { return }
        store.addTransaction(amount: amountDouble, category: category, note: note.isEmpty ? nil : note, isIncome: isIncome)
        dismiss()
    }
}
