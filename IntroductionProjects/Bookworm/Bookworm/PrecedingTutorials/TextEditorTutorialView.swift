//
//  TextEditorTutorialView.swift
//  Bookworm
//
//  Created by Paulina Dąbrowska on 27/01/2023.
//

import SwiftUI

struct TextEditorTutorialView: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorTutorialView()
    }
}
