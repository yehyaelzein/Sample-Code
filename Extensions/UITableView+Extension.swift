//
//  UITableView+Extension.swift
//
//  Created by Yehya El Zein on 8/16/18.


import Foundation
import UIKit

extension UITableView{
    open override func draw(_ rect: CGRect) {
        super.draw(rect);
        HideScrollBars();
    }
    func DeSelectSelectedRow(animated:Bool){
        if let indexPathForSelectedRow = self.indexPathForSelectedRow{
            self.deselectRow(at: indexPathForSelectedRow, animated: animated);
        }
    }
    func HideScrollBars(){
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
    }
}
