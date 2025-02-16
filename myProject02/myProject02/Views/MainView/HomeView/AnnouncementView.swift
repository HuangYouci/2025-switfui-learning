//
//  AnnouncementView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct AnnouncementView : View {
    
    @StateObject private var announcementModel = AnnouncementViewModel()
    
    var body: some View {
        
        LazyVStack {
            
            ForEach(announcementModel.announcements) { announcement in
                
                VStack{
                    
                    HStack{
                        
                        Text("\(announcement.emoji)")
                            .font(.title)
                            .padding(.trailing, 5)
                        
                        VStack{
                            HStack{
                                Text("\(announcement.title)")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack{
                                Text("\(announcement.subtitle)")
                                    .foregroundColor(Color(.systemGray2))
                                    .font(.caption)
                                Spacer()
                            }
                            
                            Divider()
                                .padding(.vertical, 5)
                            
                            HStack{
                                Text("\(announcement.content)")
                                    .font(.callout)
                                Spacer()
                            }
                        }
            //            Image(systemName: "chevron.right")
            //                .foregroundColor(Color(.systemGray))
            //                .padding(.trailing, 5)
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.1))
                    .background(BlurView(style: .systemThinMaterial))
                    .cornerRadius(10)
                    
                }
                
            }
        
        }
        .onAppear {
            announcementModel.fetchAnnouncements()
        }
    }
}
