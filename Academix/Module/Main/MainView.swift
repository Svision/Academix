//
//  MainView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI
import Firebase

struct MainView: View {
    let defaults = UserDefaults.standard
    @State private var tabSelection: Int = ItemType.home.rawValue
    @State var firstLoad: Bool = true
    @EnvironmentObject var viewModel: AppViewModel
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("light_gray"))
        
        let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let previousVersion = defaults.string(forKey: "appVersion")
        if previousVersion == nil {
            // first launch
            defaults.set(currentAppVersion, forKey: "appVersion")
            defaults.synchronize()
            do {
                try Auth.auth().signOut()
                defaults.removeObject(forKey: defaultsKeys.currUser)
            } catch {
                print("Error info: \(error)")
            }
            exit(-1)
        } else if previousVersion == currentAppVersion {
            // same version
        } else {
            // other version
            defaults.set(currentAppVersion, forKey: "appVersion")
            defaults.synchronize()
        }
        if (!defaults.bool(forKey: "hasRunBefore")) {
            print("The app is launching for the first time. Setting UserDefaults...")
            
            do {
                try Auth.auth().signOut()
                defaults.removeObject(forKey: defaultsKeys.currUser)
            } catch {
                print("Error info: \(error)")
            }
            // Update the flag indicator
            defaults.set(true, forKey: "hasRunBefore")
            defaults.synchronize() // This forces the app to update userDefaults
            
            // Run code here for the first launch
        } else {
            print("The app has been launched before. Loading UserDefaults...")
            // Run code here for every other launch but the first
        }
        if defaults.getObject(forKey: defaultsKeys.currUser, castTo: User.self) == nil {
            tabSelection = ItemType.me.rawValue
        }
    }
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                TabView(selection: $tabSelection) {
                    HomeView(courses: $viewModel.currUser.courses)
                        .tabItem { Item(type: .home, selection: tabSelection) }
                        .tag(ItemType.home.rawValue)
                    FriendsView(friendChats: $viewModel.currUser.friendChats)
                        .tabItem { Item(type: .friends, selection: tabSelection) }
                        .tag(ItemType.friends.rawValue)
                    PlanView()
                        .tabItem { Item(type: .plan, selection: tabSelection) }
                        .tag(ItemType.plan.rawValue)
                    MeView()
                        .tabItem { Item(type: .me, selection: tabSelection) }
                        .tag(ItemType.me.rawValue)
                }
                .navigationBarHidden(itemType.isNavigationBarHidden(selection: tabSelection))
                .navigationBarTitle(itemType.title, displayMode: .inline)
                .navigationBarItems(leading: itemType.navigationBarLeadingItems(selection: tabSelection),
                                    trailing: itemType.navigationBarTrailingItems(selection: tabSelection))
                .onAppear(perform: load)
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
    
    func load() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        if !firstLoad { return }
        print("loading...")
//        DispatchQueue.main.async {
        for course in viewModel.currUser.courses { course.fetchAllMessages() }
        for chat in viewModel.currUser.friendChats { chat.getThisDM() }
        viewModel.currUser.saveSelf(forKey: defaultsKeys.currUser)
//        }
        firstLoad = false
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
            case .home:     return NSLocalizedString("Home", comment: "")
            case .friends:  return NSLocalizedString("Friends", comment: "")
            case .plan:     return NSLocalizedString("Plan", comment: "")
            case .me:       return NSLocalizedString("Me", comment: "")
            }
        }
        
        func isNavigationBarHidden(selection: Int) -> Bool {
            selection == ItemType.home.rawValue // || selection == ItemType.me.rawValue
        }
        
        func navigationBarLeadingItems(selection: Int) -> AnyView {
            switch ItemType(rawValue: selection)! {
            case .home:
                return AnyView(EmptyView())
            case .friends:
                return AnyView(NavigationLink(destination: SearchFriendsView()) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                })
            case .plan:
                return AnyView(NavigationLink(destination: SearchCoursesView()) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                })
            case .me:
                return AnyView(EmptyView())
            }
        }
        
        func navigationBarTrailingItems(selection: Int) -> AnyView {
            switch ItemType(rawValue: selection)! {
            case .home:
                return AnyView(EmptyView())
            case .friends:
                return AnyView(NavigationLink(destination: AddNewFriendView()) {
                    Image(systemName: "person.badge.plus")
                        .foregroundColor(.primary)
                })
            case .plan:
                return AnyView(NavigationLink(destination: EditPlanView()) {
                    Image(systemName: "pencil")
                        .foregroundColor(.primary)
                })
            case .me:
                return AnyView(NavigationLink(destination: MeSettingView()) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.primary)
                })
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
        MainView()
    }
}
