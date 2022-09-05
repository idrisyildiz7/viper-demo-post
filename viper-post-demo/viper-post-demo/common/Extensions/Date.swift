
import Foundation

extension Date {
    
    func isSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        return
        calendar.component(.year, from: self) == calendar.component(.year, from: date) &&
        calendar.component(.month, from: self) == calendar.component(.month, from: date)
    }
    
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return
        calendar.component(.year, from: self) == calendar.component(.year, from: date) &&
        calendar.component(.month, from: self) == calendar.component(.month, from: date) && calendar.component(.day, from: self) == calendar.component(.day, from: date)
    }
    
    func component(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    func components(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func readableFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
    
    /// Returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    ///Age Calculator
    func ageCalculator() -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

