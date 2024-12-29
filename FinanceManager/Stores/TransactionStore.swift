import CoreData
import SwiftUI

class TransactionStore: ObservableObject {
    private let viewContext: NSManagedObjectContext
    @Published var transactions: [TransactionEntity] = []
    @Published var budgets: [BudgetEntity] = []
    
    init() {
        self.viewContext = PersistenceController.shared.container.viewContext
        
        DispatchQueue.main.async {
            self.fetchTransactions()
            self.fetchBudgets()
        }
    }
    
    func fetchTransactions() {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TransactionEntity.date, ascending: false)]
        
        do {
            transactions = try viewContext.fetch(request)
        } catch {
            print("Ошибка загрузки транзакций: \(error)")
        }
    }
    
    func fetchBudgets() {
        let request = NSFetchRequest<BudgetEntity>(entityName: "BudgetEntity")
        
        do {
            budgets = try viewContext.fetch(request)
        } catch {
            print("Ошибка загрузки бюджетов: \(error)")
        }
    }
    
    func addTransaction(amount: Double, category: Category, note: String?, isIncome: Bool) {
        let transaction = TransactionEntity(context: viewContext)
        transaction.id = UUID()
        transaction.amount = amount
        transaction.category = category.rawValue
        transaction.date = Date()
        transaction.note = note
        transaction.isIncome = isIncome
        
        saveContext()
        fetchTransactions()
    }
    
    func addBudget(category: Category, limit: Double, period: String) {
        let budget = BudgetEntity(context: viewContext)
        budget.id = UUID()
        budget.category = category.rawValue
        budget.limit = limit
        budget.period = period
        
        saveContext()
        fetchBudgets()
    }
    
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Ошибка сохранения контекста: \(error)")
            }
        }
    }
} 