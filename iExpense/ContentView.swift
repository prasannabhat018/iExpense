//
//  ContentView.swift
//  iExpense
//
//  Created by Prasanna Bhat on 18/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                // using for each inside list because
                // * ForEach has onDelete method
                // .. It can't be present in list beacause list has provision for both static and dynamic data
                ForEach(expenses.items) { item in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.rawValue)
                                .font(.caption)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currencySymbol ?? "INR"))
                    }
                    .listRowInsets(EdgeInsets())
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(expenses.style(of: item), lineWidth: 2)
                    )
                }
                .onDelete(perform: expenses.remove(at:))
                .listStyle(PlainListStyle())
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView() {
                    expenses.save(expense: $0)
                    showingAddExpense = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
