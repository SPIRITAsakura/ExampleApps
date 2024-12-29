import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    var amount: Double
    var category: Category
    var date: Date
    var note: String?
    var isIncome: Bool
    
    init(id: UUID = UUID(), amount: Double, category: Category, date: Date = Date(), note: String? = nil, isIncome: Bool = false) {
        self.id = id
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
        self.isIncome = isIncome
    }
}

enum Category: String, Codable, CaseIterable {
    case food = "Еда"
    case transport = "Транспорт"
    case entertainment = "Развлечения"
    case utilities = "Коммунальные услуги"
    case shopping = "Покупки"
    case other = "Другое"
}
