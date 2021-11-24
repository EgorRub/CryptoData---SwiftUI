//
//  ContentView.swift
//  CryptoData - SwiftUI
//
//  Created by Егор on 23.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var cryptoRates: [Data] = []
    
    var body: some View {
        List {
            ForEach(cryptoRates, id: \.id) { crypto in
                DisclosureGroup(crypto.symbol ?? "") {
                    Text(AttributedString(crypto.discribtion.joined(separator: "\n")))
                }
            }
        }
        .onAppear(perform: sendRequest)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private func sendRequest() {
        NetworkManager.shared.fetchData { crypto, cryptoRates in
            DispatchQueue.main.async {
                for cryptoRate in cryptoRates {
                    self.cryptoRates.append(cryptoRate)
                }
            }
        }
    }
}




