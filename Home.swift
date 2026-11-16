import SwiftUI
import CoreData

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedCategory = ""

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    Spacer()
                    NavigationLink(destination: UserProfile()) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                
                // Hero Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Little Lemon")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    Text("Chicago")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Image("hero-image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                    
                    TextField("Search menu...", text: $searchText)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding()
                .background(Color(red: 0.2, green: 0.3, blue: 0.2))
                
                // Menu Breakdown (Категории)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        Button("Starters") { selectedCategory = "Starters" }
                        Button("Mains") { selectedCategory = "Mains" }
                        Button("Desserts") { selectedCategory = "Desserts" }
                        Button("Drinks") { selectedCategory = "Drinks" }
                    }
                    .padding()
                }
                
                // Food Menu List (Список из Core Data с фильтрацией и сортировкой)
                FetchedResults(
                    predicate: buildPredicate(),
                    sortDescriptors: [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
                ) { (dishes: FetchedResults<Dish>) in
                    List(dishes) { dish in
                        NavigationLink(destination: Text(dish.title ?? "")) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(dish.title ?? "").font(.headline)
                                    Text(dish.dishDescription ?? "").font(.subheadline).foregroundColor(.gray)
                                    Text("$\(dish.price ?? "0.00")").font(.callout)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .task {
                await NetworkManager.getMenuData(viewContext: viewContext)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}
