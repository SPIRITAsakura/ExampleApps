import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "FinanceManager")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                // Выводим более подробную информацию об ошибке
                print("❌ Ошибка CoreData:", error)
                print("❌ Описание:", error.localizedDescription)
                print("❌ Отладочное описание:", error.debugDescription)
                print("❌ Информация:", error.userInfo)
                
                fatalError("Ошибка инициализации CoreData: \(error)")
            }
        }
        
        // Дополнительные настройки контекста
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // Настройка обработки ошибок
        container.viewContext.shouldDeleteInaccessibleFaults = true
    }
    
    // Вспомогательный метод для предварительного просмотра
    static var preview: PersistenceController {
        let controller = PersistenceController()
        let context = controller.container.viewContext
        
        // Создаем 10 примеров транзакций
        for _ in 0..<10 {
            let transaction = TransactionEntity(context: context)
            transaction.id = UUID()
            transaction.amount = Double.random(in: 100...1000)
            transaction.category = Category.allCases.randomElement()?.rawValue
            transaction.date = Date()
            transaction.isIncomeValue = Bool.random()
        }
        
        return controller
    }
}