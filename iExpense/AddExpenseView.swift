//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Prasanna Bhat on 19/08/24.
//

import SwiftUI

struct AddExpenseView: View {
    // View Inputs
    @State private var name: String = ""
    @State private var type: ExpenseType = .personel
    @State private var amount: Double = 0
    
    // For Output
    var didAddExpense: ((Expense) -> Void)
    
    // Alert
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                Picker("Expense Type",
                       selection: Binding(get: { type.rawValue },
                                          set: { newValue in
                    type = ExpenseType(rawValue: newValue) ?? .personel
                })) {
                    ForEach(ExpenseType.allCases, id: \.rawValue) {
                        Text($0.rawValue)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencySymbol ?? "INR"))
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    didSubmit()
                }
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("Ok") {
                reset()
            }
        }
    }
    
    private func reset() {
        name = ""
        type = .personel
        amount = 0
        showingAlert = false
        alertMessage = ""
    }
    
    private func didSubmit() {
        if name.isEmpty || amount <= 0 {
            alertMessage = "Expense Invalid"
            showingAlert = true
        } else {
            didAddExpense(Expense(name: name,
                                  type: type,
                                  amount: amount))
            reset()
        }
    }
}

#Preview {
    AddExpenseView(didAddExpense: { _ in
        // do nothing
    })
}
