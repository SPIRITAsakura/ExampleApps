import CoreData

extension TransactionEntity {
    var isIncome: Bool {
        get {
            self.isIncomeValue
        }
        set {
            self.isIncomeValue = newValue
        }
    }
}
