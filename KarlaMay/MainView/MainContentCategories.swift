//
//  MainContentCategories.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI


enum MainViewSections: String, CaseIterable {
    case clinical = "Clinical"
    case laboratory = "Laboratory"
    case administrative = "Administrative"
    case academic = "Academic"
    case analytics = "Analytics"
    
    var subcategories: [subcategories] {
        switch self{
        case .clinical:
            return [.mainClincalWorkList, .allClinicalWorkLists, .patients, .tags]
        case .laboratory:
            return [.standardOperatingProcedures, .meeting]
        case .administrative:
            return [.PCI, .antimicrobialStewardship, .billing, .otherMeetings]
        case .academic:
            return [.teaching, .maintenanceOfCertification]
        case .analytics:
            return [.clinicalAnalysis, .financialAnalysis]
        }
    }
    
    var color: Color {
        switch self{
        case .clinical:
            return Color.blue
        case .laboratory:
            return Color.green
        case .administrative:
            return Color.gray
        case .academic:
            return Color.yellow
        case .analytics:
            return Color.red
        }
    }
    
    enum subcategories: String, CaseIterable {
        case mainClincalWorkList = "Main clinical work list"
        case allClinicalWorkLists = "All clinical work lists"
        case patients = "Patients"
        case tags = "Tags"
        case standardOperatingProcedures = "Protocols"
        case meeting = "Meetings"
        case teaching = "Teaching"
        case maintenanceOfCertification = "Maintenance of certification"
        case PCI = "PCI"
        case antimicrobialStewardship = "Stewardship"
        case billing = "Billing"
        case otherMeetings = "Other meetings"
        case clinicalAnalysis = "Data analysis"
        case financialAnalysis = "Billing analysis"
        
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
            case .standardOperatingProcedures:
                return Image(systemName: "eyedropper")
            case .meeting:
                return Image(systemName: "person.3")
            case .teaching:
                return Image(systemName: "book")
            case .maintenanceOfCertification:
                return Image(systemName: "rosette")
            case .PCI:
                return Image(systemName: "bed.double")
            case .antimicrobialStewardship:
                return Image(systemName: "staroflife")
            case .billing:
                return Image(systemName: "suit.diamond")
            case .otherMeetings:
                return Image(systemName: "person.3")
            case .clinicalAnalysis:
                return Image(systemName: "sum")
            case .financialAnalysis:
                return Image(systemName: "function")
            }
        }
    }
}
