//
//  RightMenuVC.swift
//
//  Created by SaraAwad on 8/12/18.
import Foundation
import UIKit
import SnapKit

class RightMenuVC: UIViewController{
    var menuView = UIView()
    var dimmedView = UIView()
    var controller = UIViewController()
    var navController = UINavigationController()
    var delegate: RightMenuVCDelegate! = nil
    var isLikeLocale = true
    var IsDefaultRTL = Locale.current.languageCode! == CULTURE.ARABIC.rawValue
    var IsRTL = LocalRepository.GetCulture() == CULTURE.ARABIC.rawValue;
    var size:CGFloat = 300;
    
    init(isLikeLocaleOrientation: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        size = UIDevice.current.userInterfaceIdiom == .pad ? self.view.frame.width * 0.6 : self.view.frame.width * 0.7
        Helper.Delay(0.5) {
            self.isLikeLocale = isLikeLocaleOrientation
            self.LoadDimmedView()
            self.LoadMenuView()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func Initialize(){
        if let result = delegate.rightMenu?(IsOppositeLocale: self){
            isLikeLocale = !result
        }
        InitializeController()
        PanGestureHandler()
        if delegate.rightMenu?(ViewControllerFor: self) == nil{
            BackButtonHandler()
        }
    }
    func InitializeController(){
        if delegate.rightMenu?(ViewControllerFor: self) != nil{
            self.controller = delegate.rightMenu!(ViewControllerFor: self)!
        }else{
            let storyboard = UIStoryboard(name: delegate.rightMenu!(StoryboardNameFor: self), bundle: nil)
            self.controller = storyboard.instantiateViewController(withIdentifier: delegate.rightMenu!(ViewControllerIdFor: self))
            self.navController = UINavigationController(rootViewController: controller)
            self.navController.edgesForExtendedLayout = []
            self.controller.edgesForExtendedLayout = []
        }
    }
    
    func LoadDimmedView(){
        self.dimmedView.removeFromSuperview()
        UIApplication.shared.keyWindow?.addSubview(self.dimmedView)
        UIApplication.shared.keyWindow?.bringSubviewToFront(self.dimmedView)
        self.dimmedView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow!)
        }
    }
    func LoadMenuView(){
        self.menuView.removeFromSuperview()
        UIApplication.shared.keyWindow?.addSubview(self.menuView)
        
        self.menuView.snp.makeConstraints { (make) in
            make.top.equalTo(UIApplication.shared.keyWindow!)
            make.bottom.equalTo(UIApplication.shared.keyWindow!)
            if isLikeLocale{
                if IsRTL{
                    make.trailing.equalTo(UIApplication.shared.keyWindow!.snp.leading)
                }else{
                    make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing)
                }
            }else{
                if !IsRTL{
                    make.trailing.equalTo(UIApplication.shared.keyWindow!.snp.leading)
                }else{
                    make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing)
                }
            }
            make.width.equalTo(size)
        }
        self.dimmedView.backgroundColor = .gray
        dimmedView.layer.opacity = 0.0
        menuView.layer.opacity = 0.0
        self.view.updateConstraints()
    }
    func LoadTitle(){
        let title = delegate.rightMenu?(PageTitle: self) == nil ? "" : delegate.rightMenu!(PageTitle: self)
        self.controller.title = title
        self.controller.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white ,NSAttributedString.Key.font: UIFont(name:Constants.DEFAULT_FONT , size: 21)!];
        self.controller.navigationController?.navigationBar.tintColor = UIColor.white;
        self.controller.navigationController?.navigationBar.barTintColor = Constants.NAVIGATION_BAR_COLOR;
    }
    func LoadTitleView(){
        let titleView = delegate.rightMenu?(PageTitleView: self) == nil ? UIView() : delegate.rightMenu!(PageTitleView: self)
        self.controller.navigationItem.titleView = titleView
    }
    func LoadLeftBarItems(){
        let items = delegate.rightMenu?(leftNavigationItemsFor: self) != nil ? delegate.rightMenu!(leftNavigationItemsFor: self) : [UIBarButtonItem]()
        self.controller.navigationItem.leftBarButtonItems = items
    }
    func LoadRightBarItems(){
        let items = delegate.rightMenu?(rightNavigationItemsFor: self) != nil ? delegate.rightMenu!(rightNavigationItemsFor: self) : [UIBarButtonItem]()
        self.controller.navigationItem.rightBarButtonItems = items
    }
    func LoadNavBarBackgroundColor(){
        let color = delegate.rightMenu?(navBarBackgroundColor: self) != nil ? delegate.rightMenu!(navBarBackgroundColor: self) : Constants.NAVIGATION_BAR_COLOR
        self.controller.navigationController?.navigationBar.barTintColor = color
    }
    
    func PanGestureHandler(){
        if delegate.rightMenu?(shouldAddPanGesture: self) != nil{
            if delegate.rightMenu!(shouldAddPanGesture: self){
                let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
                pan.cancelsTouchesInView = false
                self.menuView.addGestureRecognizer(pan)
                self.menuView.isUserInteractionEnabled = true
            }
        }
    }
    func BackButtonHandler(){
        if delegate.rightMenu?(shouldAddBackButton: self) != nil{
            if delegate.rightMenu!(shouldAddBackButton: self){
                if delegate.rightMenu?(leftNavigationItemsFor: self) != nil{
                    if delegate.rightMenu!(leftNavigationItemsFor: self).count == 0{
                        self.AddBackBarButton()
                    }
                }else{
                    self.AddBackBarButton()
                }
            }
        }
    }
    
    func AddBackBarButton(){
        let backButton: UIButton = UIButton(type: UIButton.ButtonType.custom);
        backButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15) ;
        backButton.setImage(UIImage(named:"")?.withRenderingMode(.alwaysTemplate), for: .normal);
        if IsRTL{
            backButton.transform = CGAffineTransform(rotationAngle:CGFloat.pi)
        }else{
            backButton.transform = CGAffineTransform.identity
        }
        backButton.tintColor = .white;
        backButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.accessibilityIdentifier = "backbtn"
        backButton.setTitleColor(.white, for: .normal)
        let backMenuButtonItem: UIBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(self.Back), for: .touchUpInside)
        self.controller.navigationItem.setLeftBarButton(backMenuButtonItem, animated: true)
    }
    @objc func Back() {
        Close(force: true)
    }
    @objc func handlePan(_  gestureRecognizer: UIPanGestureRecognizer) {
        if IsDefaultRTL(){
            return;
        }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: UIApplication.shared.keyWindow!)
            // note: 'view' is optional and need to be unwrapped
            if ((gestureRecognizer.view!.frame.origin.x + translation.x) > (self.view.frame.size.width - size)) || translation.x > 0{
                gestureRecognizer.view!.snp.updateConstraints({ (make) in
                   make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing).offset(-(self.view.frame.size.width - gestureRecognizer.view!.frame.origin.x - translation.x))
                })
                gestureRecognizer.view!.superview?.layoutIfNeeded()
                self.dimmedView.layer.opacity = Float((self.view.frame.size.width - 600) * (0.7/gestureRecognizer.view!.frame.origin.x))
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            }
        }
        else if gestureRecognizer.state == .ended{
            if gestureRecognizer.view!.frame.origin.x > (self.view.frame.size.width - 250){
                Close()
            }else{
                Open()
            }
        }
    }

    func Open(){
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
        if delegate.rightMenu?(ViewControllerFor: self) == nil{
            self.present(self.navController, animated: true, completion: nil)
            menuView.addSubview(self.navController.view)
            self.navController.view.snp.makeConstraints { (make) in
                make.edges.equalTo(menuView)
            }
        }else{
            menuView.addSubview(self.controller.view)
            self.controller.didMove(toParent: self)
            addChild(self.controller)
            self.controller.view.snp.makeConstraints { (make) in
                make.edges.equalTo(menuView)
            }
        }
        self.menuView.layer.opacity = 1.0
        UIView.animate(withDuration: TimeInterval(0.6)) {
            self.dimmedView.layer.opacity = 0.7
        }
        Helper.Delay(0.1){
            UIView.animate(withDuration: 0.6, animations: {
                self.menuView.snp.updateConstraints({ (make) in
                    if self.isLikeLocale{
                        if self.IsRTL{
                            make.trailing.equalTo(UIApplication.shared.keyWindow!.snp.leading).offset(self.size)
                        }else{
                            make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing).offset(-self.size)
                        }
                    }else{
                        if !self.IsRTL{
                            make.trailing.equalTo(UIApplication.shared.keyWindow!.snp.leading).offset(self.size)
                        }else{
                            make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing).offset(-self.size)
                        }
                    }
                })
                self.menuView.superview?.layoutIfNeeded()
            }) { (true) in
                self.delegate.rightMenu!(DidOpen: self)
                UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
            }
        }
        if delegate.rightMenu?(ViewControllerFor: self) == nil{
            LoadTitle()
            if delegate.rightMenu?(PageTitleView: self) != nil{
                LoadTitleView()
            }
            if delegate.rightMenu?(leftNavigationItemsFor: self) != nil{
                LoadLeftBarItems()
            }
            if delegate.rightMenu?(rightNavigationItemsFor: self) != nil{
                LoadRightBarItems()
            }
            LoadNavBarBackgroundColor()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.Close))
        self.dimmedView.addGestureRecognizer(tap)
        self.dimmedView.isUserInteractionEnabled = true
        UIApplication.shared.keyWindow?.bringSubviewToFront(self.dimmedView)
        UIApplication.shared.keyWindow?.bringSubviewToFront(self.menuView)
        
    }
    
    @objc func Close(force: Bool = false){
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
        if self.dimmedView.gestureRecognizers != nil {
            for gest in self.dimmedView.gestureRecognizers!{
                self.dimmedView.removeGestureRecognizer(gest)
            }
        }
        UIApplication.shared.keyWindow?.endEditing(true)
        UIView.animate(withDuration: TimeInterval(0.6)) {
            self.dimmedView.layer.opacity = 0
        }
        UIView.animate(withDuration: 0.6, animations: {
            self.menuView.snp.updateConstraints({ (make) in
                if self.isLikeLocale{
                    if !self.IsRTL{
                        make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing)
                    }else{
                        make.trailing.equalTo(UIApplication.shared.keyWindow!.snp.leading)
                    }
                }else{
                    if self.IsRTL{
                        make.leading.equalTo(UIApplication.shared.keyWindow!.snp.trailing)
                    }else{
                        make.trailing.equalTo(UIApplication.shared.keyWindow!.snp.leading)
                    }
                }
            })
            self.menuView.superview?.layoutIfNeeded()
        }) { (true) in
            self.menuView.layer.opacity = 0.0
            for sbv in self.menuView.subviews{
                sbv.removeFromSuperview()
            }
            if let del = self.delegate{
                if del.rightMenu?(DidClose: self) != nil{
                    del.rightMenu!(DidClose: self)
                    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
                }
            }
        }
    }
}
