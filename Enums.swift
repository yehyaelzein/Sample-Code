
import Foundation

enum USER_ROLE:Int{
    case USER=0, ADMIN
}
enum TANK_SHAPE:Int{
    case H_CYL=0, V_CYL, RECTANGLE
}
enum ERROR_TYPES:Int{
    case DEFAULT = 0
    case API_ERROR = 1
    case CNXN_ERROR = 2
    case ALREADY_EXISTS = 3
    case ALERT_CNXN_ERROR = 4
    case INVALID_ACCESS_TOKEN = 6
    case OTHER = 5
}
enum NAVIGATION_TITLE_TYPE: Int {
    case TITLE = 0
    case CUSTOM_VIEW = 1
    case IMAGE = 2
}
enum CULTURE:String{
    case ENGLISH = "en"
    case ARABIC = "ar"
}
enum MONTH: Int {
    case JANUARY = 1,FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER
}
enum NOTIFICATION_TRIGGER_TYPE:Int{
    case TIME=0,DATE, DATETIME
}

enum SIGN_IN_METHOD:Int{
    case FACEBOOK=1, GOOGLE, CUSTOM
}
