//
//  MainView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    let defaults = UserDefaults.standard
    
    @Published var signedIn = false
    @Published var errorMessage: String?
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
            } else {
                DispatchQueue.main.async {
                    self?.signedIn = true
                    self?.defaults.set(email, forKey: defaultsKeys.email)
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
            } else {
                DispatchQueue.main.async {
                    self?.signedIn = true
                    self?.defaults.set(email, forKey: defaultsKeys.email)
                }
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
        self.defaults.set("NONE", forKey: defaultsKeys.email)
    }
}

struct MainView: View {
    @State private var tabSelection: Int = 0
    @State var friendChats: [FriendChat] = FriendChat.all
    @State var courses: [CourseModel] = CourseModel.all
    @EnvironmentObject var viewModel: AppViewModel
    init() {
        let defaults = UserDefaults.standard
        if (!defaults.bool(forKey: "hasRunBefore")) {
            print("The app is launching for the first time. Setting UserDefaults...")
            
            do {
                try Auth.auth().signOut()
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
    }
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                TabView(selection: $tabSelection) {
                    HomeView(courses: $courses)
                        .tabItem { Item(type: .home, selection: tabSelection) }
                        .tag(ItemType.home.rawValue)
                    FriendsView(chats: $friendChats)
                        .tabItem { Item(type: .friends, selection: tabSelection) }
                        .tag(ItemType.friends.rawValue)
                    PlanView()
                        .tabItem { Item(type: .plan, selection: tabSelection) }
                        .tag(ItemType.plan.rawValue)
                    MeView()
                        .tabItem { Item(type: .me, selection: tabSelection) }
                        .tag(ItemType.me.rawValue)
                }
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
        for chat in friendChats {
            chat.getThisDM()
        }
        for course in courses {
            course.readAllMsgs()
        }
        guard friendChats.isEmpty, courses.isEmpty else { return }
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
            case .home:     return ""
            case .friends:  return NSLocalizedString("Friends", comment: "")
            case .plan:     return NSLocalizedString("Plan", comment: "")
            case .me:       return NSLocalizedString("Me", comment: "")
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
                type.rawValue == ItemType.home.rawValue ? Text("Home") : Text(type.title)
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
