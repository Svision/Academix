//
//  ViewModel.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

public class ViewModelSample : ObservableObject {
    func updateView(){
        self.objectWillChange.send()
    }
}
