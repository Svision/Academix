//
//  ContentView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                HomeView()
                    .tabItem { Item(type: .home, selection: tabSelection) }
                    .tag(ItemType.home.rawValue)
                FriendsView()
                    .tabItem { Item(type: .friends, selection: tabSelection) }
                    .tag(ItemType.friends.rawValue)
                PlanView()
                    .tabItem { Item(type: .plan, selection: tabSelection) }
                    .tag(ItemType.plan.rawValue)
                MeView()
                    .tabItem { Item(type: .me, selection: tabSelection) }
                    .tag(ItemType.me.rawValue)
            }
            // .navigationBarHidden(itemType.isNavigationBarHidden(selection: tabSelection))
            .navigationBarTitle(itemType.title, displayMode: .inline)
            .navigationBarItems(leading: itemType.navigationBarLeadingItems(selection: tabSelection),
                                trailing: itemType.navigationBarTrailingItems(selection: tabSelection))
        }
    }
    
    enum ItemType: Int {
        case home
        case friends
        case plan
        case me
        
        var image: Image {
            switch self {
            case .home:     return Image(systemName: "house")
            case .friends:  return Image(systemName: "person.2")
            case .plan:     return Image(systemName: "calendar")
            case .me:       return Image(systemName: "person.circle")
            }
        }
        
        var selectedImage: Image {
            switch self {
            case .home:     return Image(systemName: "house.fill")
            case .friends:  return Image(systemName: "person.2.fill")
            case .plan:     return Image(systemName: "calendar")
            case .me:       return Image(systemName: "person.circle.fill")
            }
        }
        
        var title: String {
            switch self {
            case .home:     return "Home"
            case .friends:  return "Firends"
            case .plan:     return "Plan"
            case .me:       return "Me"
            }
        }
        
        func isNavigationBarHidden(selection: Int) -> Bool {
            selection == ItemType.home.rawValue
        }
        
        func navigationBarTrailingItems(selection: Int) -> AnyView {
            switch ItemType(rawValue: selection)! {
            case .home:
                return AnyView(EmptyView())
            case .friends:
                return AnyView(Image(systemName: "person.badge.plus"))
            case .plan:
                return AnyView(Image(systemName: "arrow.up.arrow.down"))
            case .me:
                return AnyView(Image(systemName: "gearshape"))
            }
        }
        
        func navigationBarLeadingItems(selection: Int) -> AnyView {
            switch ItemType(rawValue: selection)! {
            case .home:
                return AnyView(EmptyView())
            case .friends:
                return AnyView(Image(systemName: "magnifyingglass"))
            case .plan:
                return AnyView(EmptyView())
            case .me:
                return AnyView(EmptyView())
            }
        }
    }
    
    struct Item: View {
        let type: ItemType
        let selection: Int
        
        var body: some View {
            VStack {
                type.rawValue == selection ? type.selectedImage : type.image
                
                Text(type.title)
            }
        }
    }
    
    private var itemType: ItemType { ItemType(rawValue: tabSelection)! }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
