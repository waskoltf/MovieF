import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SeenMoviesView()
                .tabItem {
                    Label("Seen Movies", systemImage: "eye")
                }
        }
    }
}
