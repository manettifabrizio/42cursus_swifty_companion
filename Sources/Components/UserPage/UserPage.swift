//
//  UserView.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI

struct UserPage: View {
    
    @State var user: User;
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(user.displayName)")
                    .foregroundStyle(Color("custom_orange"))
                    .font(Font.custom("IBMPlexMono-Regular", size: 30).weight(.bold))
                Spacer()
                
            }
            HStack {
                Spacer()
                Text(user.getTitle())
                    .foregroundStyle(.gray)
                Spacer()
                
            }
            HStack {
                UserDetails(
                    detail_1: UserDetailType(name: "wallet", detail: "\(user.wallet) ₳"),
                    detail_2: UserDetailType(name: "evaluation points", detail: "\(user.correction_point)")
                )
                Spacer()
                AsyncImage(url: user.getUrlPicture()) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 180, height: 180)
                            .clipped()
                            .border(Color("custom_orange"), width: 2)
                            .padding(.horizontal ,10)
                    } else if phase.error != nil {
                        Color.red
                    } else {
                        Color.blue
                    }
                }
                Spacer()
                UserDetails(
                    detail_1: UserDetailType(name: "cursus", detail: "\(user.getCursusName())"),
                    detail_2: UserDetailType(name: "grade", detail: "\(user.getCursusGrade())")
                )
            }
            Text(user.location ?? "Unavailable")
                .foregroundStyle(.white)
                .font(Font.custom("IBMPlexMono-Regular", size: 30))
            LevelBar(level: user.getLevel())
            UserProjectsNSkills(user_projects: user.projectsUsers, user_skills: user.getSkills())
        }
        .font(Font.custom("IBMPlexMono-Regular", size: 14))
        .padding([.leading, .trailing], 20)
        .background(.black)
    }
}
