
import Foundation
import UIKit

class Helper{
    
    static var currentOverlay =  UIView();
    static var indicatorView = UIActivityIndicatorView();
    
    static func Delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    static func DisplayNA(_ stringToCheck:String, placeholder:String)->String{
        return stringToCheck == "" ? String(format: "%@ %@", placeholder, "N/A") : String(format: "%@ %@", placeholder, stringToCheck)
    }
    static func StringToDate(dateStr:String,dateFormat:String) ->Date{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat;
        dateformatter.locale = Locale(identifier: Constants.DATE_LOCALE);
        dateformatter.timeZone = TimeZone(abbreviation: "UTC")!
        if let dateObject = dateformatter.date(from: dateStr){
            print("data object \(dateObject)")
            return dateObject
        }
        return Date();
    }
    static func DateToString(dateString: Date,format:String) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format;
        dateFormatter.locale = Locale(identifier: Constants.DATE_LOCALE);
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
        return dateFormatter.string(from: dateString);
    }
    static func FormatDate(fromDateFormat:String,toDateFormat:String,dateString:String)->String{
        let dateObject = StringToDate(dateStr:dateString,dateFormat:fromDateFormat)
        //Date(dateString: dateString, format: fromDateFormat);
        let dateStringResult = DateToString(dateString: dateObject,format:toDateFormat)
        return dateStringResult
    }
    static func AddValueToDateTime(dateTime:String, value:Int)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm";
        dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        if let dateObject = dateformatter.date(from: dateTime){
            var calendar = Calendar.current;
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            if let newDate = calendar.date(byAdding: .minute, value: value, to: dateObject){
                let hour = calendar.component(.hour, from: newDate);
                let minute = calendar.component(.minute, from: newDate);
                return ("\(hour):\(minute)")
            }
        }
        return "";
            
    }
    static func RemoveTrailingZeros(_ number: Double,text:String = "")->String{
        let formatterWithSeparator: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.groupingSeparator = ","
            formatter.locale = Locale(identifier: Constants.DATE_LOCALE)
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            return formatter
        }()
        formatterWithSeparator.allowsFloats = true
        let result = formatterWithSeparator.string(from: NSNumber(value: number)) == nil ? "" : formatterWithSeparator.string(from: NSNumber(value: number))!
        let returnedNumber = text == "" ? result : "\(result)\(text)"
        return returnedNumber;
    }
    static func IsTextFieldEmpty(textFields: [UITextField]) -> Bool {
        var result = Bool();
        for textField in textFields {
            if ((textField.text?.isEmpty)! || textField.text == "") {
                result = true;
                break;
            } else {
                result = false;
            }
        }
        
        return result;
    }
    static func DisableEnableButton(buttonToChange:UIButton, textFields: [UITextField]){
        if(!IsTextFieldEmpty(textFields: textFields))
        {
            buttonToChange.backgroundColor = UIColor.blue
            buttonToChange.isEnabled = true;
        }
        else
        {
            buttonToChange.backgroundColor = UIColor.lightGray
            buttonToChange.isEnabled = false;
        }
    }
    static func GetLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        
        return lbl.frame.size.height
    }
    static func ShowLoading(loadingText: String = "") {
        // Clear it first in case it was already shown
        HideLoading()
        let overlay = UIView()
        UIApplication.shared.keyWindow?.addSubview(overlay)
        UIApplication.shared.keyWindow?.bringSubviewToFront(overlay)
        
        overlay.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow!)
        }
        
        overlay.backgroundColor = UIColor.clear;
        
        let loadingBackgroundView = UIView();
        loadingBackgroundView.backgroundColor =  loadingText == "" ? UIColor.clear : Constants.DEFAULT_APP_COLOR.withAlphaComponent(0.95)
        loadingBackgroundView.layer.cornerRadius =  (UIApplication.shared.keyWindow?.frame.size.height)! * 0.015
        overlay.addSubview(loadingBackgroundView)
        loadingBackgroundView.snp.makeConstraints { (make) in
            make.centerX.equalTo(overlay)
            make.centerY.equalTo(overlay).offset(-10)
            make.width.equalTo(300)
            make.height.equalTo(150)
            
        }
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.size.width)! / 10, height: ( UIApplication.shared.keyWindow?.frame.size.height)! / 10))
        
        if(loadingText != ""){
            loadingBackgroundView.addSubview(indicator)
            indicator.snp.makeConstraints { (make) in
                make.width.equalTo(loadingBackgroundView).multipliedBy(0.1)
                make.height.equalTo(loadingBackgroundView).multipliedBy(0.06)
                make.centerX.equalTo(loadingBackgroundView)
                make.top.equalTo(loadingBackgroundView).offset(25)
            }
        }
        else{
            UIApplication.shared.keyWindow?.addSubview(indicator)
            
            indicator.snp.makeConstraints { (make) in
                make.width.equalTo(UIApplication.shared.keyWindow!).multipliedBy(0.1)
                make.height.equalTo(UIApplication.shared.keyWindow!).multipliedBy(0.06)
                make.centerY.equalTo(UIApplication.shared.keyWindow!)
                make.centerX.equalTo(UIApplication.shared.keyWindow!)
            }
        }
        indicator.style = .whiteLarge
        indicator.color = UIColor.white;
        indicator.contentMode = .scaleToFill
        indicator.startAnimating()
        indicatorView = indicator;
        UIApplication.shared.ShowNetworkIndicator();
        // Create label
        if  loadingText != "" {
            let loadingLB = UILabel();
            loadingLB.text = loadingText
            loadingLB.textColor = UIColor.white;
            loadingLB.textAlignment = .center
            loadingLB.font = UIFont(name: Constants.DEFAULT_FONT, size: Constants.MEDIUM_FONT)
            loadingLB.numberOfLines = 0
            loadingLB.lineBreakMode = .byWordWrapping;
            
            loadingBackgroundView.addSubview(loadingLB)
            loadingLB.snp.makeConstraints({ (make) in
                make.centerY.equalTo(loadingBackgroundView).offset(10)
                make.leading.equalTo(loadingBackgroundView).offset(20)
                make.trailing.equalTo(loadingBackgroundView).offset(-20)
            })
            
        }
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.commitAnimations()
        currentOverlay = overlay;
    }
    static func HideLoading() {
        currentOverlay.removeFromSuperview();
        indicatorView.removeFromSuperview();
        UIApplication.shared.HideNetworkIndicator()
    }
    static func ShowLoadMoreLoading() {
        // Clear it first in case it was already shown
        HideLoadMoreLoading()
        let overlay = UIView()
        UIApplication.shared.keyWindow?.addSubview(overlay)
        UIApplication.shared.keyWindow?.bringSubviewToFront(overlay)
        
        overlay.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow!)
        }
        overlay.backgroundColor = UIColor.clear;
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.size.width)! / 10, height: ( UIApplication.shared.keyWindow?.frame.size.height)! / 10))
        
        UIApplication.shared.keyWindow?.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(UIApplication.shared.keyWindow!)
            make.bottom.equalTo(UIApplication.shared.keyWindow!).offset(-25)
        }
        
        indicator.style = .whiteLarge
        indicator.color =  Constants.DEFAULT_APP_COLOR ;
        indicator.contentMode = .scaleToFill
        indicator.startAnimating()
        indicatorView = indicator;
        
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.commitAnimations()
        currentOverlay = overlay;
    }
    static func HideLoadMoreLoading() {
        currentOverlay.removeFromSuperview();
        indicatorView.removeFromSuperview();
        UIApplication.shared.HideNetworkIndicator()
    }
    static func LoadNoLabel(parentView: UIView)->UILabel{
        let noLabel = UILabel();
        noLabel.font = UIFont(name:Constants.DEFAULT_FONT, size: 22);
        noLabel.textColor = Constants.DEFAULT_APP_COLOR;
        noLabel.textAlignment = .center;
        noLabel.text = "".localeString("no_data");
        parentView.addSubview(noLabel);
        noLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(parentView)
            make.centerX.equalTo(parentView)
        })
        return noLabel;
    }
    static func FormatTime(_ timeString: String, fromFormat:String = Constants.TIME_FULL_FORMAT, toFormat:String = Constants.TIME_FORMAT)->(Date,String){
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: Constants.DATE_LOCALE)
        inFormatter.dateFormat = fromFormat;
        
        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: Constants.DATE_LOCALE)
        outFormatter.dateFormat = toFormat;
        
        let dateobj = inFormatter.date(from: timeString)!
        let timeStr = outFormatter.string(from: dateobj)
        return (dateobj,timeStr);
    }
    
    static func LabelStyling(titles:NSString..., values:[NSString], colors:[UIColor], backgroundColors:[UIColor] = [UIColor.clear, UIColor.clear], fonts: [CGFloat]) -> NSMutableAttributedString{
        if titles.count != colors.count && values.count != titles.count{
            return NSMutableAttributedString();
        }
        var result = NSMutableAttributedString()
        var paragraphStyle = NSMutableParagraphStyle();
        paragraphStyle.alignment = .right
        for i in 0..<titles.count{
            let title = titles[i];
            var myTitle = NSAttributedString()
            myTitle = NSAttributedString(string: title as String + " ", attributes: [
                NSAttributedString.Key.font:UIFont(name:Constants.DEFAULT_FONT,size:fonts[i])!,
                NSAttributedString.Key.foregroundColor: colors[i],
                NSAttributedString.Key.backgroundColor: backgroundColors[i],
                NSAttributedString.Key.paragraphStyle: paragraphStyle
                ])
            result.append(myTitle)
            if values.count > 0 && values.count == titles.count{
                let value = values[i];
                let valueStr:NSString = value;
                var myValue = NSAttributedString()
                myValue = NSAttributedString(string: valueStr as String, attributes: [
                    NSAttributedString.Key.font:UIFont(name:Constants.DEFAULT_FONT,size:fonts[1])!,
                    NSAttributedString.Key.foregroundColor:colors[1],
                    NSAttributedString.Key.backgroundColor: backgroundColors[1]])
                result.append(myValue)
            }
        }
        return result;
    }
    
    static func LabelHTMLStyling(titles:NSString..., colors:[UIColor], backgroundColors:[UIColor] = [UIColor.clear, UIColor.clear], fonts: [CGFloat]) -> NSMutableAttributedString{
        if titles.count != colors.count{
            return NSMutableAttributedString();
        }
        var result = NSMutableAttributedString()
        var paragraphStyle = NSMutableParagraphStyle();
        paragraphStyle.alignment = .right
        for i in 0..<titles.count{
            let title = titles[i];
            let data = (title as String).data(using: String.Encoding.unicode)!
            let descriptionAttHTML = try? NSMutableAttributedString(data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil);
                descriptionAttHTML?.addAttributes([
                    NSAttributedString.Key.font:UIFont(name:Constants.DEFAULT_FONT,size:fonts[0])!,
                    NSAttributedString.Key.foregroundColor: colors[0],
                    NSAttributedString.Key.backgroundColor: backgroundColors[0],
                    NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: (title as String).count))
            
            result.append(descriptionAttHTML!)
        }
        
        return result;
    }
   
    static func DisplayAlertMessage(title: String, description: String, view: UIViewController) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"".localeString("dismiss"), style: .default) { (action: UIAlertAction!) in}
        alertController.addAction(OKAction)
        view.present(alertController, animated: true, completion: nil)
    }
    static func ConvertImagesToBase64(image:UIImage)->String{
        var finalImage = image
        var percentage:CGFloat = 1.0
        var imgData = finalImage.jpegData(compressionQuality: percentage)!
        var imageSize: Int = imgData.count
        while((Double(imageSize) / 1024.0) > 200){
            if percentage <= 0{
                finalImage = UIImage(data: imgData)!
                break;
            }else{
                if percentage <= 0.11{
                    percentage -= 0.01
                }else{
                    percentage -= 0.1
                }
            }
            imgData = finalImage.jpegData(compressionQuality: percentage)!
            imageSize = imgData.count
            print("percentage \(percentage)")
            print("img size \(imageSize)")
        }
        let convertedImage = imgData.base64EncodedString();
        return convertedImage;
    }
    
    //This function is responsible for setting up a new textfield and adding a line under it
    //Parameters
    //txtField -> textfield you wish to setup
    //placeHolder -> textfield place holder
    //
    //Returns
    //view that contains textfield and a line under it
    static func SetupTextField(txtField: UITextField,placeHolder: String) -> UIView{
        let view = UIView()
        let line = UIView()
        line.backgroundColor = Constants.BUTTON_COLOR
        view.addSubview(txtField)
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(txtField.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalTo(view)
        }
        txtField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.7)])
        txtField.textColor = .white
        txtField.font = UIFont(name: txtField.font!.fontName, size: Constants.LARGE_FONT)
        txtField.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(view)
        }
        view.snp.makeConstraints { (make) in
            make.height.equalTo(55)
        }
        return view
    }
    
    //This function is responsible for getting hours and minutes from minutes and presenting them in 00h 00m format
    //Parameters
    //minutes: Number of minutes
    //
    //Returns
    //String: Formatted hours and minutes
    static func GetHoursAndMinutes(minutes: Int) -> String{
        let hrs = minutes/60
        let minutes = minutes % 60
        return "\(hrs > 10 ? String(hrs) : "0\(hrs)")h \(minutes > 10 ? String(minutes) : "0\(minutes)")m"
    }
    
    //This function is responsible for getting the weekday
    //parameters
    //date: date to get day from
    //format: date sent format
    //returns
    //String: week day
    static func GetDayOfWeek(_ date:String, format: String = "yyyy-MM-dd") -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = format
        guard let todayDate = formatter.date(from: date) else { return "Sunday" }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        let days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        return days[(weekDay - 1)]
    }
    
    static func GetTankShapeString(shape: String) -> String{
        return shape == "h_cyl" ? Shape.h_cyl.rawValue : (shape == "v_cyl" ? Shape.v_cyl.rawValue : Shape.rect.rawValue)
    }
    
    static func FormatNumber(number: Float) -> String{
        return String.init(format: "%.1f", number);
    }
}
