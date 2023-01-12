//
//  AddNewView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/13.
//

import SwiftUI

struct AddNewView: View {
    /// - Callback
    var onAdd: (MyTask) -> ()
    
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskCategory: Category = .personal
    
    /// - Category Animation Properties
    @State private var animateColor: Color = Category.personal.color
    @State private var animate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }
                
                Text("새 일정 등록하기")
                    .hyemin(25, .regular)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                
                TitleView("제목")
                
                TextField("제목", text: $taskName)
                    .hyemin(16, .bold)
                    .tint(.white)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("날짜")
                    .padding(.top, 15)
                
                HStack(alignment: .bottom, spacing: 12) {
                    HStack(spacing: 12) {
                        Text(taskDate.toString("MMMM d, EEEE"))
                            .hyemin(16, .regular)
                        
                        /// - Custom Date Picker
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay {
                                DatePicker("", selection: $taskDate, displayedComponents:  [.date])
                                    .blendMode(.destinationOver)
                                /// - opacity를 조절하면 뷰가 숨겨져서 tab이 안됨
                                /// 그래서 blendMode로 가려주는거
                            }
                    }
                    .padding(.vertical, 5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                    }
                    
                    HStack(spacing: 12) {
                        Text(taskDate.toString("hh:mm a", isLocale: false))
                            .hyemin(16, .regular)
                        
                        /// - Custom Date Picker
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay {
                                DatePicker("", selection: $taskDate, displayedComponents: [.hourAndMinute])
                                    .blendMode(.destinationOver)
                                /// - opacity를 조절하면 뷰가 숨겨져서 tab이 안됨
                                /// 그래서 blendMode로 가려주는거
                            }
                    }
                    .padding(.vertical, 5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                    }
                }
                .padding(.bottom, 15)
            }
            .environment(\.colorScheme, .dark)
            .hAlign(.leading)
            .padding(15)
            .background {
                ZStack {
                    taskCategory.color
                    
                    GeometryReader {
                        let size = $0.size
                        Rectangle()
                            .fill(animateColor)
                            .mask {
                                Circle()
                            }
                            .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                    }
                    .clipped()
                }
                .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                TitleView("메모", .gray)
                
                TextField("메모", text: $taskDescription)
                    .hyemin(16, .regular)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .frame(height: 1)
                
                TitleView("카테고리", .gray)
                    .padding(.top, 15)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        Text(category.rawValue.uppercased())
                            .hyemin(14, .regular)
                            .hAlign(.center)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(category.color.opacity(0.25))
                            }
                            .foregroundColor(category.color)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                guard !animate else { return }
                                animateColor = category.color
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)) {
                                    animate = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    animate = false
                                    taskCategory = category
                                }
                            }
                    }
                }
                .padding(.top, 5)
                
                Button {
                    /// - Creating Task And Pass it to the callback
                    let myTask = MyTask(id: "1", dateAdded: taskDate, taskName: taskName, taskDescription: taskDescription, taskCategory: taskCategory)
                    onAdd(myTask)
                    dismiss()
                } label: {
                    Text("등록")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .hAlign(.center)
                        .background {
                            Capsule()
                                .fill(animateColor)
                        }
                }
                .vAlign(.bottom)
                .disabled(taskName.isEmpty || animate)
                .opacity(taskName.isEmpty ? 0.5 : 1)
            }
            .padding(15)
        }
        .vAlign(.top)
    }
    
    @ViewBuilder
    func TitleView(_ value: String, _ color: Color = .white.opacity(0.7)) -> some View {
        Text(value)
            .hyemin(16, .bold)
            .foregroundColor(color)
    }
}

struct AddNewView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewView() { task in
            
        }
    }
}
