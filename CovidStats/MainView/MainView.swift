//
//  ContentView.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/22.
//


import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                ZStack(alignment: .top) {
                    LinearGradient(colors: [
                        Color(red: 0.76, green: 0.15, blue: 0.26),
                        Color(red: 0.01, green: 0.23, blue: 0.5)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading) {
                        Text("世界の総数")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(10)
                        
                        TotalDataView(totalData: viewModel.totalData)
                        
                        if viewModel.isSearchVisible {
                            SearchBarView(searchText: $viewModel.searchText)
                        }
                        
                        Text("全ての国")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(10)
                        
                        List {
                            Section {
                                ForEach(viewModel.allCountries.filter{
                                    viewModel.searchText.isEmpty ? true : $0.name.lowercased().contains(viewModel.searchText.lowercased())
                                }, id: \.iso) { country in
                                    NavigationLink {
                                        CountryDetailView(viewModel: CountryDetailViewModel(country: country))
                                        
                                    } label: {
                                        Text(country.name)
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle("Covid-19の統計")
                .alert(item: $viewModel.alertItem, content: { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                })
                .toolbar {
                    Button {
                        viewModel.isSearchVisible.toggle()
                        if !viewModel.isSearchVisible {
                            viewModel.searchText = "" // reset text
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                        
                    }
                    .tint(.white)
                }
                .accentColor(.primary)
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("統計")
            }
            .tag(0)
            
            MapContaineriew()
                .tabItem {
                    Image(systemName: "map")
                    Text("地図")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
