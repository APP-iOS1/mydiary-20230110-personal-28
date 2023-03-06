//
//  HomeView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import SwiftUI

struct HomeView: View {
    // MARK: View Properties
    @State private var currentDay: Date = .init()
    @State private var myTasks: [MyTask] = sampleTasks
    @State private var addNewTask: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TimelineView()
                .padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
        .fullScreenCover(isPresented: $addNewTask) {
            AddNewView { task in
                myTasks.append(task)
            }
        }
    }
    
    /// - Timeline View
    @ViewBuilder
    func TimelineView() -> some View {
        ScrollViewReader { proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack {
                ForEach(hours, id: \.self) { hour in
                    TimelineViewRow(hour).id(hour)
                }
            }
            .onAppear {
                proxy.scrollTo(midHour)
            }
        }
    }
    
    /// - Timeline View Row
    @ViewBuilder
    func TimelineViewRow(_ date: Date) -> some View {
        HStack(alignment: .top) {
            Text(date.toString("h a", isLocale: false))
                .hyemin(14, .regular)
                .frame(width: 45, alignment: .center)
            
            /// - Filtering Tasks
            let calendar = Calendar.current
            let filteredTasks = myTasks.filter {
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                   hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay) {
                    return true
                }
                return false
            }
            
            if filteredTasks.isEmpty {
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 7))
                    .frame(height: 0.5)
                    .offset(y: 10)
            } else {
                /// - Task View
                VStack(spacing: 10) {
                    ForEach(filteredTasks) { task in
                        TaskRow(task)
                    }
                }
            }
            
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    
    /// - Header View
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("나의 오늘")
                        .hyemin(28, .regular)
                    
                    Text("오늘의 할일과 일정")
                        .hyemin(17, .regular)
                }
                .hAlign(.leading)
                
                Button {
                    addNewTask.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("할일 추가")
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            
            /// - Today Date in String
            Text(Date().toString("YYYY년 M월"))
                .hyemin(17, .bold)
                .hAlign(.leading)
                .padding(.top, 15)
            
            /// - Current Week Row
            WeekRow()
        }
        .padding(15)
        .background {
            VStack(spacing: 0) {
                Color.white
                
                /// - Gradient Opacity Background
                Rectangle()
                    .fill(.linearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
    }
    
    /// - Week Row
    @ViewBuilder
    func WeekRow() -> some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6) {
                    Text(weekDay.string.prefix(1))
                        .hyemin(13, .bold)
                    Text(weekDay.date.toString("dd"))
                        .hyemin(17, status ? .bold : .regular)
                }
                .foregroundColor(status ? Color("Blue") : .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 1)
        .padding(.horizontal, -15)
    }
    
    @ViewBuilder
    func TaskRow(_ task: MyTask) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.taskName)
                .hyemin(16, .bold)
                .foregroundColor(task.taskCategory.color)
            
            if task.taskDescription != "" {
                Text(task.taskDescription)
                    .hyemin(14, .regular)
                    .foregroundColor(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
