
import Foundation
import UIKit

extension UIViewController{
    public func HideUIApplicationKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.DismissApplicationKeyboard))
        tap.cancelsTouchesInView = false;
        UIApplication.shared.keyWindow?.addGestureRecognizer(tap)
    }
    @objc func DismissApplicationKeyboard(){
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    public func HideUIViewKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.DismissKeyboard))
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap)
    }
    @objc public func DismissKeyboard() {
        view.endEditing(true)
    }
    public func RemoveChildrenViewController(parentController:UIViewController){
        
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                if viewContoller != parentController{
                    viewContoller.willMove(toParent: nil)
                    viewContoller.view.removeFromSuperview()
                    viewContoller.removeFromParent()
                }
            }
        }
    }
    public func CustomizeChildController<T:UIViewController>(storyboard:String,identifier:String)-> T {
        let storyboard = UIStoryboard(name: storyboard, bundle:nil)
        let controller:T = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        controller.view.frame = self.view.frame
        controller.view.frame.origin = CGPoint(x: 0, y: 0)
        return controller
    }
    public func AddChildController<T:UIViewController>(parentController:T){
        parentController.view.addSubview(self.view)
        parentController.addChild(self)
        self.didMove(toParent: parentController)
    }
    func LoadNavigationBarTitle(viewController: UIViewController, navigationTitleType: NAVIGATION_TITLE_TYPE = .TITLE, customTitle: AnyObject? = nil, titleText:String = ""){
        switch (navigationTitleType){
        case .TITLE:
            viewController.navigationItem.title = titleText;
            viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                                      NSAttributedString.Key.font: UIFont(name: Constants.DEFAULT_FONT, size: 22) ?? UIFont()];
        case .IMAGE:
            let imageName = "manar_title_logo";
            //"ic_manarbar"
            if (UIImage(named: imageName) != nil){
                let logoView = UIView()
                logoView.frame = CGRect(x:0,y:-10,width:200,height:40)
                let logoImage = (UIImageView(image: UIImage(named: imageName)))
                logoImage.frame = CGRect(x:0,y:0,width:logoView.frame.width * 0.90,height:logoView.frame.height * 0.90)
                logoImage.contentMode = .scaleAspectFit
                logoView.addSubview(logoImage)
                viewController.navigationItem.titleView = logoView
            } else {
                print("FILE NOT AVAILABLE")
            }
        default:
            break;
            
        }
        viewController.navigationController?.navigationBar.barTintColor = Constants.NAVIGATION_BAR_COLOR;
        viewController.navigationController?.navigationBar.tintColor = UIColor.white;
        viewController.navigationController?.navigationBar.barStyle = .black;
        
        let imgBack = UIImage(named: "")
        viewController.navigationController?.navigationBar.backIndicatorImage = imgBack
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        viewController.navigationItem.leftItemsSupplementBackButton = true
        viewController.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        UIApplication.shared.statusBarStyle = .default;
    }
//    public func AddChildViewController<T:UIViewController>(storyboard:String,identifier:String, parentView:UIView)-> T {
//        let storyboard = UIStoryboard(name: storyboard, bundle:nil)
//        let controller:T = storyboard.instantiateViewController(withIdentifier: identifier) as! T
//        controller.view.frame = parentView.frame
//        controller.view.frame.origin = CGPoint(x: 0, y: 0)
//        controller.willMove(toParentViewController: self)
//        parentView.addSubview(controller.view)
//        self.addChildViewController(controller)
//        controller.didMove(toParentViewController: self)
//        return controller
//    }
    public func ShowVC<T:UIViewController>(storyboardIdentifier:String, identifier:String)->T?{
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil);
        if let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T{
            self.navigationController?.pushViewController(vc, animated: true);
            return vc;
        }
        return nil;
    }
    func IsRTL()->Bool{
        return LocalRepository.GetCulture() == CULTURE.ARABIC.rawValue;
    }
    func IsDefaultRTL()->Bool{
        return Locale.current.languageCode! == CULTURE.ARABIC.rawValue ? true : false
    }
    func IsSameLanguage() -> Bool{
        return IsRTL() == IsDefaultRTL()
    }
    func SetupSemanticContent(){
        self.view.backgroundColor = Constants.BACKGROUND_COLOR;
        self.view.UpdateSemantics();
        self.navigationController?.navigationBar.semanticContentAttribute = IsRTL() ? .forceRightToLeft : .forceLeftToRight;
    }
    func ShowDimmedView()->UIView{
        let dimmedView = UIView();
        self.view.addSubview(dimmedView);
        dimmedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        dimmedView.backgroundColor = UIColor.black;
        dimmedView.layer.opacity = Constants.DIMMED_VIEW_OPACITY;
        dimmedView.isUserInteractionEnabled = true;
        dimmedView.accessibilityIdentifier = "dv";
        dimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HideDimmedView(_:))));
        return dimmedView
    }
    @objc func HideDimmedView(_ sender:UITapGestureRecognizer?){
        for v in self.view.subviews{
            if v.accessibilityIdentifier == "dv"{
                v.removeFromSuperview();
            }
        }
    }

   
}

