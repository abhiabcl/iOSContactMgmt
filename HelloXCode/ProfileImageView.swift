//
//  ProfileImageView.swift
//  HelloXCode
//
//  Created by Abhishek on 1/27/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image("icon").clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
        .shadow(radius: 10)
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}
