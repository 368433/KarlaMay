//
//  ICDResults.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

class ICDresult: ObservableObject {
    @Published var results: [Diagnosis] = []
    func add(_ dx: Diagnosis) -> Void {
        self.results.append(dx)
    }
}
