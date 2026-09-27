//
//  SearchBar.swift
//  SimpleBrowser
//
//  Created by H A on 27/09/2026.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text("URL:")
            
            TextField("URL", text: $viewModel.urlString)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}
