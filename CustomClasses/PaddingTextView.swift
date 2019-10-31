//
//  PaddingTextView.swift
//  Created by SaraAwad on 11/16/18.


import Foundation
import UIKit

class PaddingTextView: UITextView {
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}

