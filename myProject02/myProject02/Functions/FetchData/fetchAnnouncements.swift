//
//  fetchAnnouncements.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/16.
//

import FirebaseFirestore

struct Announcement: Identifiable, Codable {
    @DocumentID var id: String?
        var emoji: String
        var title: String
        var subtitle: String
        var content: String
}

class AnnouncementViewModel: ObservableObject {
    @Published var announcements: [Announcement] = []
    private let db = Firestore.firestore()
    
    func fetchAnnouncements() {
        db.collection("system").document("announcement").collection("data")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.announcements = documents.compactMap { try? $0.data(as: Announcement.self) }
            }
    }
    
    func addAnnouncement(emoji: String, title: String, subtitle: String, content: String) {
        let newAnnouncement = Announcement(id: nil, emoji: emoji, title: title, subtitle: subtitle, content: content)
        do {
            _ = try db.collection("system").document("announcement").collection("data").addDocument(from: newAnnouncement)
        } catch {
            print("Error adding announcement: \(error.localizedDescription)")
        }
    }
    
    func updateAnnouncement(_ announcement: Announcement) {
        guard let id = announcement.id else { return }
        do {
            try db.collection("system").document("announcement").collection("data").document(id).setData(from: announcement)
        } catch {
            print("Error updating announcement: \(error.localizedDescription)")
        }
    }
    
    func deleteAnnouncement(_ announcement: Announcement) {
        guard let id = announcement.id else { return }
        db.collection("system").document("announcement").collection("data").document(id).delete { error in
            if let error = error {
                print("Error deleting announcement: \(error.localizedDescription)")
            }
        }
    }
}
