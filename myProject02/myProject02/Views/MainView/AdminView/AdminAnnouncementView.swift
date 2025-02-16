//
//  AdminAnnouncementView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/16.
//

import SwiftUI

struct AdminAnnouncementView: View {
    
    @StateObject private var viewModel = AnnouncementViewModel()
    @State private var showAddAnnouncement = false
    @State private var editingAnnouncement: Announcement?
    
    var body: some View {
        VStack {
            
            HStack{
                Text("公告設置")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button(action: { showAddAnnouncement.toggle() }) {
                    Label("新增公告", systemImage: "plus")
                }
            }
            .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.announcements) { announcement in
                        VStack {
                            HStack {
                                Text("\(announcement.emoji)")
                                    .font(.title)
                                    .padding(.trailing, 5)
                                VStack(alignment: .leading) {
                                    Text(announcement.title)
                                        .font(.title3)
                                    Text(announcement.subtitle)
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    Divider()
                                    Text(announcement.content)
                                        .font(.callout)
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground).opacity(0.1))
                        .background(BlurView(style: .systemThinMaterial))
                        .cornerRadius(10)
                        .contextMenu {
                            Button(role: .destructive, action: { viewModel.deleteAnnouncement(announcement) }) {
                                Label("刪除", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .padding()
            .background(
                BlurView(style: .systemThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .edgesIgnoringSafeArea(.all)
            
        }
        .background(Image("bgLogin").opacity(0.3))
        .onAppear {
            viewModel.fetchAnnouncements()
        }
        .sheet(isPresented: $showAddAnnouncement) {
            AddAnnouncementView(viewModel: viewModel)
        }
    }
}

struct AddAnnouncementView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AnnouncementViewModel
    @State private var emoji = ""
    @State private var title = ""
    @State private var subtitle = ""
    @State private var content = ""
    
    var body: some View {
        VStack {
            
            HStack{
                Text("新增公告")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button("儲存") {
                    viewModel.addAnnouncement(emoji: emoji, title: title, subtitle: subtitle, content: content)
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            VStack{
                
                HStack{
                    
                    TextField("🔥", text: $emoji)
                        .font(.title)
                        .frame(width: 30)
                        .padding(.trailing, 5)
                    
                    VStack{
                        HStack{
                            TextField("標題", text: $title)
                                .font(.title3)
                            Spacer()
                        }
                        HStack{
                            TextField("副標題", text: $subtitle)
                                .foregroundColor(Color(.systemGray2))
                                .font(.caption)
                            Spacer()
                        }
                        
                        Divider()
                            .padding(.vertical, 5)
                        
                        HStack{
                            TextEditor(text: $content)
                                .frame(height: 300)
                                .font(.callout)
                            Spacer()
                        }
                    }
                }
                
            }
            .padding()
            .background(Color(.systemGroupedBackground).opacity(0.1))
            .background(BlurView(style: .systemThinMaterial))
            .cornerRadius(10)
            .padding()
            
        }
    }
}
