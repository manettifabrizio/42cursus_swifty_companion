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
                    UserProjectNSkill(name: project.project.name, value: String(project.final_mark ?? 0), value_style: project.final_mark ?? 0 > 80 ? .green : .red)
                }
                .modifier(UnstyledListModifier())
                .transition(
                    .move(edge: .leading)
                    .combined(with: .opacity)
                    .animation(.easeInOut(duration: 0.5)))
            } else {
                List(user_skills) { skill in
                    UserProjectNSkill(name: skill.name, value: String(format: "%g", skill.level), value_style: Color("custom_orange"))
                }
                .modifier(UnstyledListModifier())
                .transition(
                    .move(edge: .trailing)
                    .combined(with: .opacity)
                    .animation(.easeInOut(duration: 0.5)))
            }
        }
    }
}
