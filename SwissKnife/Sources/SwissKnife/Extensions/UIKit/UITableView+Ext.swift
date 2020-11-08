//
//  UITableView+Ext.swift
//  SwissKnife
//

import UIKit

extension UITableView {
    /// Warning: The function returns only the sum of all heights of table view rows for specific section.
    /// - Parameter excludeIndexes: exclude given rows indexes from height calculation. Indexes array is empty by default.
    /// - Parameter section: The section that you wanna calculate its rows height. By default the function calcualate first section #0
    @objc public func rowsHeight(excludeIndexes: [Int] = [], forSection section: Int = 0) -> CGFloat {
        let numOfRows = self.numberOfRows(inSection: 0)
        let contentHeight = stride(from: 0, to: numOfRows, by: 1).reduce(CGFloat(0)) {
            // Don't consider the spacing cell if tableview content height calculation
            $0 + (excludeIndexes.contains($1) ? 0 : rectForRow(at: IndexPath(row: $1, section: section)).height)
        }
        return contentHeight
    }
}
