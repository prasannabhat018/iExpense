//
//  ViewModel.swift
//  iExpense
//
//  Created by Prasanna Bhat on 19/08/24.
//

import Foundation
import SwiftUI

struct Expense: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType: String, CaseIterable, Codable {
    case personel = "Personel"
    case business = "Business"
}

@Observable
class Expenses {
    private static let defaultsKey = "ExpenseItems"
    
    private(set) var items = [Expense]()
    
    func save(expense: Expense) {
        items.insert(expense, at: 0)
        persist()
    }
    
    func remove(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        persist()
    }
    
    private func persist() {
        if let savedItemsData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(savedItemsData, forKey: Expenses.defaultsKey)
        }
    }
    
    init() {
        if let savedItemsData = UserDefaults.standard.data(forKey: Expenses.defaultsKey) {
            if let savedItems = try? JSONDecoder().decode([Expense].self, from: savedItemsData) {
                items = savedItems
                return
            }
        }
        items = []
    }
    
    func style(of expense: Expense) -> Color {
        switch expense.amount {
        case 0...10:
            return Color.green
        case 11...100:
            return Color.orange
        case 101...:
            return Color.red
        default:
            return Color.gray
        }
    }
}

