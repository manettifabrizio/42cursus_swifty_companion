//
//  UserProjects.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI

struct UserProjectsNSkills: View {
    @State var user_projects: [ProjectUsers];
    @State var user_skills: [Skills]
    @State var isProjectSelected: Bool = true;
    
    func filterProjects() -> [ProjectUsers] {
        return user_projects.filter { $0.status == "finished" }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Button(action: {
                    withAnimation {
                        isProjectSelected = true
                    }
                }, label: {
                    Text("Projects")
                        .font(Font.custom("IBMPlexMono-Regular", size: 30)).underline()
                        .foregroundStyle(isProjectSelected ? .white : .gray)
                })
                Spacer()
                Button(action: {
                    withAnimation {
                        isProjectSelected = false
                    }
                }, label: {
                    Text("Skills")
                        .font(Font.custom("IBMPlexMono-Regular", size: 30)).underline()
                        .foregroundStyle(isProjectSelected ? .gray : .white)
                })
            }
            if (isProjectSelected) {
                List(filterProjects()) { project in
                    HStack {
                        Text(project.project.name)
                            .foregroundStyle(.white)
                            .font(Font.custom("IBMPlexMono-Regular", size: 20).weight(.bold))
                        Spacer()
                        Text("\(project.final_mark ?? 0)")
                            .foregroundStyle(project.final_mark ?? 0 > 80 ? .green : .red)
                            .font(Font.custom("IBMPlexMono-Regular", size: 20).weight(.bold))
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 8)
                }
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .listStyle(PlainListStyle())
                .transition(
                    .move(edge: .leading)
                    .combined(with: .opacity)
                    .animation(.easeInOut(duration: 0.5)))
            } else {
                List(user_skills) { skill in
                    HStack {
                        Text("\(skill.name)")
                            .foregroundStyle(.white)
                            .font(Font.custom("IBMPlexMono-Regular", size: 20).weight(.bold))
                        Spacer()
                        Text("\(String(format: "%g", skill.level))")
                            .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.3820329607, blue: 0.005308574066, alpha: 1)))
                            .font(Font.custom("IBMPlexMono-Regular", size: 20).weight(.bold))
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 8)
                }
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .listStyle(PlainListStyle())
                .transition(
                    .move(edge: .trailing)
                    .combined(with: .opacity)
                    .animation(.easeInOut(duration: 0.5)))
            }
        }
    }
}
