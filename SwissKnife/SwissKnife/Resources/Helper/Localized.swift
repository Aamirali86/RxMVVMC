/// Auto generated file. Please don't modify me!

import Foundation

private class DummyBundleClass {}

private extension String {

    // swiftlint:disable localized_not_NSLocalized
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: DummyBundleClass.self), comment: "")
    }
}

enum Localized {
    /// min
    static func swissMin() -> String {
        return "swiss_min".localized
    }
    /// mins
    static func swissMinPlural() -> String {
        return "swiss_min_plural".localized
    }
    /// sec
    static func swissSec() -> String {
        return "swiss_sec".localized
    }
    /// secs
    static func swissSecPlural() -> String {
        return "swiss_sec_plural".localized
    }
    /// Today
    static func swissToday() -> String {
        return "swiss_today".localized
    }
    /// Tomorrow
    static func swissTomorrow() -> String {
        return "swiss_tomorrow".localized
    }
}
