//
//  favoriteTourAttractions.swift
//  final_00757128
//
//  Created by User13 on 2021/1/19.
//

import SwiftUI

struct favoriteTourAttractions: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest/*讀出資料*/(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink(
                            destination: tourDetail(detailOfTour: TourAttractionStruct(name: item.name!, info: item.info!, nearStop: item.nearStop!, passRoute: item.passRoute!)),
                            label: {
                                Image(item.name!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 60)
                                    .clipped()
                                Text(item.name!)
                            })
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("我的最愛")
        }
    }
}

/*struct favoriteTourAttractions_Previews: PreviewProvider {
 static var previews: some View {
 favoriteTourAttractions(tourAttracToPass: tourAttractions.first!)
 }
 }*/
