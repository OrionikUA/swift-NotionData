import Foundation

extension Date {
    var month: Int {
        get {
            let month = Calendar.current.component(.month, from: self)
            return month
        }
    }
    
    var day: Int {
        get {
            let day = Calendar.current.component(.day, from: self)
            return day
        }
    }
    
    var year: Int {
        get {
            let year = Calendar.current.component(.year, from: self)
            return year
        }
    }
    
    var hour: Int {
        get {
            let year = Calendar.current.component(.hour, from: self)
            return year
        }
    }
    
    var minute: Int {
        get {
            let year = Calendar.current.component(.minute, from: self)
            return year
        }
    }
    
    var second: Int {
        get {
            let year = Calendar.current.component(.second, from: self)
            return year
        }
    }
    
    var toString: String {
        let str = "\(String(format: "%02d", self.day)).\(String(format: "%02d", self.month)).\(String(format: "%04d", self.year))"
        return str
    }
    
    var dayString: String {
        let str = "\(String(format: "%04d", self.year))-\(String(format: "%02d", self.month))-\(String(format: "%02d", self.day))"
        return str
    }
}
