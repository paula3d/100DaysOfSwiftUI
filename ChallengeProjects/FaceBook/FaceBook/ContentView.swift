//
//  ContentView.swift
//  FaceBook
//
//  Created by Paulina Dąbrowska on 11/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State var selectingImage = false
    @State var namingPerson = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.people) { person in
                    NavigationLink() {
                        PersonView(person: person)
                    } label: {
                        HStack {
                            
                            Image(uiImage: person.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120, alignment: .center)
                                .cornerRadius(15)
                                .clipped()
                                
                                
                            Text(person.name)
                                .font(.headline)
                                .padding(.horizontal)
                        }
                    }
                }
                .onDelete(perform: deletePerson)
            }
            .navigationTitle("FaceBook")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // add new person
                        selectingImage = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: viewModel.inputImage) { _ in
                if viewModel.inputImage != nil {
                    namingPerson = true
                }
            }
            .sheet(isPresented: $selectingImage) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .sheet(isPresented: $namingPerson) {
                AddPersonView(people: $viewModel.people, image: viewModel.inputImage!)
            }
        }
    }
    
    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            viewModel.people.remove(at: offset)
            viewModel.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
