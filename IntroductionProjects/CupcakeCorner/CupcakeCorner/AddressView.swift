//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Paulina Dąbrowska on 26/01/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!hasFilledInAddress())
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func hasFilledInAddress() -> Bool {
        if order.hasValidAddress {
            if order.name.trimmingCharacters(in: .whitespaces).isEmpty
                || order.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
                || order.city.trimmingCharacters(in: .whitespaces).isEmpty
                || order.zip.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            } else {
                return true
            }
        }
        return false
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
