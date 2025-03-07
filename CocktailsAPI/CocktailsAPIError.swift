import Foundation

enum CocktailsAPIError: Error, LocalizedError {
    case unavailable
    case jsonParingFailed

    var errorDescription: String {
        var message = "Unable to retrieve cocktails, API unavailable"
        switch self {
        case .jsonParingFailed:
            message = "JSON Paring Error"
        default:
            break
        }
        return message
    }
    
}
