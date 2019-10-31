//
//  RightMenuVCDelegate.swift
//  TeacherTasks
//
//  Created by SaraAwad on 8/12/18.


import Foundation
import UIKit


import Foundation
import UIKit

@objc protocol RightMenuVCDelegate {
    
    // this will be called when the controller fully opens
    @objc optional func rightMenu(DidOpen controller: RightMenuVC)
    
    // this will be called when the controller fully closes
    @objc optional func rightMenu(DidClose controller: RightMenuVC)
    
    // this is used to set the navigation bar title for the cotroller
    @objc optional func rightMenu(PageTitle controller: RightMenuVC) -> String
    
    // this is used to set the navigation bar title view for the cotroller
    @objc optional func rightMenu(PageTitleView controller: RightMenuVC) -> UIView
    
    // this is used to set the navigation bar title text color for the cotroller
    @objc optional func rightMenu(navBarTintColor controller: RightMenuVC) -> UIColor
    
    // this is used to set the navigation bar background color
    @objc optional func rightMenu(navBarBackgroundColor controller: RightMenuVC) -> UIColor
    
    // this is used to send a custom view controller for the cotroller
    @objc optional func rightMenu(ViewControllerFor controller: RightMenuVC) -> UIViewController?
    
    // this is used to set the view controller id you want to open in the right menu controller
    @objc optional func rightMenu(ViewControllerIdFor controller: RightMenuVC) -> String
    
    // this is used to set the storyboard name of the view controller you want to open in the right menu controller
    @objc optional func rightMenu(StoryboardNameFor controller: RightMenuVC) -> String
    
    // this is used to set if you want the user to be able to close the menu controller by dragging with his finger
    @objc optional func rightMenu(shouldAddPanGesture controller: RightMenuVC) -> Bool
    
    // this is used to set if you want to add a back button to the controller that will close the controller when pressed
    @objc optional func rightMenu(shouldAddBackButton controller: RightMenuVC) -> Bool
    
    // this is used to set the right navigation bar items
    @objc optional func rightMenu(rightNavigationItemsFor controller: RightMenuVC) -> [UIBarButtonItem]
    
    // this is used to set the left navigation bar items
    @objc optional func rightMenu(leftNavigationItemsFor controller: RightMenuVC) -> [UIBarButtonItem]
    
    //this is used if we want to reverse the behavior of the locale
    @objc optional func rightMenu(IsOppositeLocale controller:RightMenuVC) -> Bool
    
    @objc optional func rightMenu(updateData controller: RightMenuVC) -> Bool
}
