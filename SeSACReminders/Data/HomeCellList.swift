//
//  HomeCellList.swift
//  SeSACReminders
//
//  Created by cho on 2/20/24.
//

import Foundation

enum homeCellList: String, CaseIterable {
    case today = "오늘"
    case expected = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case done = "완료됨"
    
    var cellIcons: String {
        switch self {
        case .today:
            return "13.square"
        case .expected:
            return "calendar"
        case .all:
            return "tray.fill"
        case .flag:
            return "flag.fill"
        case .done:
            return "checkmark"
        }
    }
    
    var todoListCount: Int {
        //???: 여기서 repo를 쓰는게 맞나요,,?
        let repo = TodoTableRepository()
        
        switch self {
        case .today:
            return 0
        case .expected:
            return 0
        case .all:
            return repo.fetchAllRecordCount()
        case .flag:
            return 0
        case .done:
            return repo.fetchDoneRecordCount()
        }
    }
}
