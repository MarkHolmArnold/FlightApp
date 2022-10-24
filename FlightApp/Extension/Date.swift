

import Foundation

extension Date {
    
    struct DateFormats {
        static let ddMMYYY = "MM/dd/yyyy"
    }
    
    func stringWith(Format _format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  _format
        return dateFormatter.string(from: self)
    }
    
    func daysFrom(Date _endDate:Date) -> Int {
        let calendar = Calendar.current
//        let date1 = calendar.startOfDay(for: self)
//        let date2 = calendar.startOfDay(for: _endDate)

        let days = calendar.dateComponents([.day], from: self, to: _endDate).day ?? 0
        if days == 0 {
            return 1
        }
        return days
    }
    func setDateFormat(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: date)
        return date
    }
    
    var localDate: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: self)
        }
    }
}
