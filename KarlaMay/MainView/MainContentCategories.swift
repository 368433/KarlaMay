//
//  MainContentCategories.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

enum MainViewSections  {
    case clinical(category: Int)
}

protocol SectionCategory: CaseIterable {
    var sectionTitle: String {get}
    var image: Image {get}
    var title: String {get}
}

enum ClinicalWorkCategory: String, SectionCategory{
    case mainClincalWorkList = "Main clinical work list"
    case allClinicalWorkLists = "All clinical work lists"
    case patients = "Patients"
    case tags = "Tags"
    
    var sectionTitle: String {
        return "Clinical"
    }
    
    var title: String {
        return self.rawValue
    }
    
    var image: Image {
        switch self {
        case .patients:
            return Image(systemName: "person.2")
        case .tags:
            return Image(systemName: "tag")
        case .mainClincalWorkList:
            return Image(systemName: "star.fill")
        case .allClinicalWorkLists:
            return Image(systemName: "doc.plaintext")
        }
    }
}

enum LaboratoryWorkCategory: String, SectionCategory {
    case standardOperatingProcedures = "Protocols"
    case meeting = "Meetings"
    
    var sectionTitle: String {
        return "Laboratory"
    }
    
    var title: String {
        return self.rawValue
    }
    
    var image: Image {
        switch self {
        case .standardOperatingProcedures:
            return Image(systemName: "eyedropper")
        case .meeting:
            return Image(systemName: "person.3")
        }
    }
}

enum AcademicCategory: String, CaseIterable {
    case teaching = "Teaching"
    case maintenanceOfCertification = "Maintenance of certification"
    
    var sectionTitle: String {
        return "Academic"
    }
    
    var image: Image {
        switch self {
        case .teaching:
            return Image(systemName: "book")
        case .maintenanceOfCertification:
            return Image(systemName: "rosette")
        }
    }
}

enum AdministrativeWorkCategory: String, CaseIterable {
    case PCI = "PCI"
    case antimicrobialStewardship = "Stewardship"
    case billing = "Billing"
    case otherMeetings = "Other meetings"
    
    var sectionTitle: String {
        return "Administrative"
    }
    
    var image: Image {
        switch self {
        case .PCI:
            return Image(systemName: "bed.double")
        case .antimicrobialStewardship:
            return Image(systemName: "staroflife")
        case .billing:
            return Image(systemName: "suit.diamond")
        case .otherMeetings:
            return Image(systemName: "person.3")
        }
    }
    
}

enum AnalyticsCategory: String, CaseIterable {
    case clinicalAnalysis = "Data analysis"
    case financialAnalysis = "Billing analysis"
    
    var sectionTitle: String {
        return "Analytics"
    }
    
    var image: Image {
        switch self {
        case .clinicalAnalysis:
            return Image(systemName: "sum")
        case .financialAnalysis:
            return Image(systemName: "function")
        }
    }
}
