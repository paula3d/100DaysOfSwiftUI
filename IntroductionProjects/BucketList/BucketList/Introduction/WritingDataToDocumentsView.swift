//
//  WritingDataToDocumentsView.swift
//  BucketList
//
//  Created by Paulina Dąbrowska on 04/02/2023.
//

import SwiftUI

struct WritingDataToDocumentsView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct WritingDataToDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        WritingDataToDocumentsView()
    }
}
