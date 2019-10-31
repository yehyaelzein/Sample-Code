
import Foundation
import SnapKit

class ErrorManager{
    func GetErrorObject(status: Int) -> NSError?{
        switch status {
        case ERROR_TYPES.DEFAULT.rawValue:
            return nil;
        case ERROR_TYPES.API_ERROR.rawValue:
            return NSError(domain: "", code: status, userInfo: [NSLocalizedDescriptionKey:"".localeString("api_connection_error")])
        case ERROR_TYPES.CNXN_ERROR.rawValue:
            return NSError(domain: "", code: status, userInfo: [NSLocalizedDescriptionKey:"Check Internet Connectivity Then Try Again."])
        case ERROR_TYPES.ALREADY_EXISTS.rawValue:
            return NSError(domain: "", code: status, userInfo: [NSLocalizedDescriptionKey:""])
        case ERROR_TYPES.ALERT_CNXN_ERROR.rawValue:
            return NSError(domain: "", code: status, userInfo: [NSLocalizedDescriptionKey: "Check Internet Connectivity Then Try Again."])
        case ERROR_TYPES.OTHER.rawValue:
            return NSError(domain: "", code: status, userInfo: [NSLocalizedDescriptionKey: ""])
        case ERROR_TYPES.INVALID_ACCESS_TOKEN.rawValue:
        //TODO: check if change or remove message
             return NSError(domain: "", code: status, userInfo: [NSLocalizedDescriptionKey: ""])
        default:
            return nil;
        }
    }
}
