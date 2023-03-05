//
//  AddPersonView.swift
//  FaceBook
//
//  Created by Paulina Dąbrowska on 11/02/2023.
//

import SwiftUI
import MapKit

struct AddPersonView: View {
    
    @Binding var people : [Person]
    var image : UIImage
    @State var name = ""
    
    @State var invalidData = true
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
    
    let locationFetcher = LocationFetcher()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .cornerRadius(15)
                
                VStack {
                    Text("Who is the person on the picture?")
                        .font(.headline)
                    
                    TextField("Insert full name", text: $name)
                        .onChange(of: name){ _ in
                            verifyInput()
                        }
                        .fixedSize()
                        .autocorrectionDisabled()
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .onAppear {
                self.locationFetcher.start()
            }
            
            .navigationTitle("Add new person")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let jpegData = image.jpegData(compressionQuality: 0.8) {
                            if let location = self.locationFetcher.lastKnownLocation {
                                
                                let newPerson = Person(id: UUID(), name: name, imageData: jpegData, latitude: location.latitude, longitude: location.longitude)
                                people.append(newPerson)
                                people = people.sorted()
                                save()
                                
                            } else {
                                print("Location unknown")
                            }
                        } else {
                            print("Adding new person failed")
                        }
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(invalidData)
                }
            }
        }
    }
    
    func verifyInput() {
        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            invalidData = false
        } else {
            invalidData = false
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

/*
 struct NamingView_Previews: PreviewProvider {
 
 static var previews: some View {
 AddPersonView(people: [Person.example] ,image: Person.example.image)
 }
 }*/
