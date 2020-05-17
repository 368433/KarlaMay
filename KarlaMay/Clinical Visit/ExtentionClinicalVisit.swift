//
//  ExtentionClinicalVisit.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

extension ClinicalVisit: Dated {
    var dateLabel: String {
        guard let startDate = self.startDate else { return "Missing start date"}
        return startDate.toString
    }
    
    var shortDate: String{
        guard let startDate = self.startDate else { return "n/a"}
        let formatter = DateFormatter()
        if Calendar.current.component(.weekOfYear, from: startDate) == Calendar.current.component(.weekOfYear, from: Date()) {
            formatter.dateFormat = "EEE"
            return formatter.string(from: startDate)
        }
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: startDate)
//        let day = Calendar.current.component(.day, from: startDate)
//        let month = Calendar.current.component(.month, from: startDate)
//        return "\(day)/\(month)"
    }
    
    var actLabel: String {
        guard let act = self.actType else { return "Missing act information"}
        return act
    }
}
