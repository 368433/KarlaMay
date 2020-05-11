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
        let formater = DateFormatter()
        formater.dateStyle = .full
        return formater.string(from: startDate)
    }
    
    var actLabel: String {
        guard let act = self.actType else { return "Missing act information"}
        return act
    }
}
