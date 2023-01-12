//
//  Task.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/12.
//

import Foundation

// MARK: Task Model
struct MyTask: Identifiable {
    var id: String
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}

var sampleTasks: [MyTask] = [
    .init(id: "1", dateAdded: Date.now, taskName: "코드 리뷰", taskDescription: "", taskCategory: .study),
    .init(id: "2", dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "하루", taskDescription: "", taskCategory: .personal),
    .init(id: "3", dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "플랭크 챌린지", taskDescription: "", taskCategory: .habit),
    .init(id: "4", dateAdded: Date(timeIntervalSince1970: 1672837009), taskName: "아키", taskDescription: "", taskCategory: .coffeeChat),
    .init(id: "5", dateAdded: Date(timeIntervalSince1970: 1672814609), taskName: "유진님", taskDescription: "", taskCategory: .plan),
    .init(id: "6", dateAdded: Date(timeIntervalSince1970: 1672851409), taskName: "플랭크 챌린지", taskDescription: "", taskCategory: .habit),
]
