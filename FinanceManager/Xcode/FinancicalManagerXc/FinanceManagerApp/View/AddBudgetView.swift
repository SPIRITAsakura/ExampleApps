import SwiftUI

struct AddBudgetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var store: TransactionStore
    
    @State private var category: Category = .other
    @State private var limit: String = ""
    @State private var period: String = "Месяц"
    
    let periods = ["Неделя", "Месяц", "Год"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Настройки бюджета")) {
                    Picker("Категория", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    TextField("Лимит", text: $limit)
                        .keyboardType(.decimalPad)
                    
                    Picker("Период", selection: $period) {
                        ForEach(periods, id: \.self) { period in
                            Text(period).tag(period)
                        }
                    }
                }
            }
            .navigationTitle("Новый бюджет")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        if let limitDouble = Double(limit) {
                            store.addBudget(category: category, limit: limitDouble, period: period)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
            .environmentObject(TransactionStore())
    }
} 
