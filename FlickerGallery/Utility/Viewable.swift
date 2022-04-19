//
//  Viewable.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import Foundation
import UIKit

protocol Viewable: AnyObject {
    func push(_ vc: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

extension Viewable where Self: UIViewController {

    func push(_ vc: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }

    func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }

    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

}
