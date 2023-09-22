//
//  MockGDSInstructionsViewModel.swift
//  GDSCommon-Demo
//
//  Created by McKillop, Ben on 22/09/2023.
//

import UIKit
import GDSCommon

class MockGDSInstructionsViewModel: GDSInstructionsViewModel {
    var title: GDSCommon.GDSLocalisedString
    var body: String
    var childView: UIView
    var buttonViewModel: GDSCommon.ButtonViewModel
    var secondaryButtonViewModel: GDSCommon.ButtonViewModel?
    func didAppear() {}
    
    init(title: GDSCommon.GDSLocalisedString = "This is the Instructions View",
         body: String = "We can add a subtitle here to give some extra context",
         childView: UIView = BulletView(title: "This is the bullet view",
                                        text: ["Here we can list things we want the user to know",
                                               "we can use this as a way to step them through an action",
                                               "or give details of a process"]),
         buttonViewModel: GDSCommon.ButtonViewModel,
         secondaryButtonViewModel: GDSCommon.ButtonViewModel? = nil) {
        self.title = title
        self.body = body
        self.childView = childView
        self.buttonViewModel = buttonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
    }
}
