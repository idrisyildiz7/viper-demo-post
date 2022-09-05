import Foundation
enum DateFormat: String {
    case hourMinute = "HH:mm"
    case history = "yyyy-MM-dd"
    case month = "MMM"
    case fullMonth = "MMMM"
    case sessionDate = "dd.MM.yyyy"
    case sessionDuration = "HH'h' mm'm'"
}

extension DateFormatter {
    convenience init(format: DateFormat, timeZone: TimeZone? = TimeZone(secondsFromGMT: 0), locale: Locale) {
        self.init()
        self.dateFormat = format.rawValue
        self.timeZone = timeZone
        self.locale = locale
    }
}
