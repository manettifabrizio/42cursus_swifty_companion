//
//  UserProjects.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI

struct UserProjects: View {
    @State var user_projects: [ProjectUsers];
    
    func filterProjects() -> [ProjectUsers] {
        return user_projects.filter { $0.status == "finished" }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Projects")
                .font(Font.custom("IBMPlexMono-Regular", size: 30)).underline()
                .foregroundStyle(.white)
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
        }
    }
}
