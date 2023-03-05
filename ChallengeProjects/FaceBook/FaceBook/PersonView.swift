//
//  PersonView.swift
//  FaceBook
//
//  Created by Paulina Dąbrowska on 12/02/2023.
//

import SwiftUI
import MapKit

struct PersonView: View {
    
    var person : Person
    
    @State private var mapRegion : MKCoordinateRegion
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Image(uiImage: person.image)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        Text(person.name)
                            .font(.headline)
                    }
                    .padding()
                    
                    ZStack {
                        
                        Text("Location unknown")
                            .padding()
                        
                        Map(coordinateRegion: $mapRegion, annotationItems: [person]) { person in
                            MapAnnotation(coordinate: person.location) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .frame(width: 300, height: 300)
                    }
                    
                }
                .padding(.horizontal)
                
                .navigationBarTitle(person.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
    }
    init(person: Person) {
        self.person = person
        _mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    }
}
/*
 struct PersonView_Previews: PreviewProvider {
 static var previews: some View {
 PersonView()
 }
 }
 */
