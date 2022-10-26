//
//  ContentView.swift
//  Sample
//
//  Created by Youssef El-Ansary on 26/10/2022.
//

import SwiftUI
import SSOManager

struct ContentView: View {
    var body: some View {
        VStack {
            Button("FB", action: {
                Task {
                    await login(strategy: .facebook)
                }
            }).padding()
            Button("Google", action: {
                Task {
                    await login(strategy: .google)
                }
            }).padding()
            Button("Apple", action: {
                Task {
                    // Not Supported Yet
                    await login(strategy: .apple)
                }
            })
        }
        .padding()
    }
    
    private func login(strategy: SSOStrategy) async {
        let result = await SSOManager.shared.signIn(strategy: strategy)
        print(result)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
