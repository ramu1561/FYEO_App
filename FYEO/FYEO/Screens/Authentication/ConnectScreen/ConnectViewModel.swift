//
//  ConnectViewModel.swift
//  FYEO
//
//  Created by Harvi Jivani on 29/01/26.
//

import Foundation

class ConnectViewModel{
    
    private(set) var users: [SuggestedUser] = [] {
        didSet{
            onUsersUpdated?()
        }
    }
    
    var onUsersUpdated:(()->Void)?
    
    func fetchSuggestedUsers() {
        //API data
        users = [
                SuggestedUser(
                    id: 1,
                    userName: "fyeo_one",
                    displayName: "User One",
                    imageUrl: "https://i.pravatar.cc/150?img=1",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 2,
                    userName: "fyeo_two",
                    displayName: "User Two",
                    imageUrl: "https://i.pravatar.cc/150?img=2",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 3,
                    userName: "fyeo_three",
                    displayName: "User Three",
                    imageUrl: "https://i.pravatar.cc/150?img=3",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 4,
                    userName: "fyeo_four",
                    displayName: "User Four",
                    imageUrl: "https://i.pravatar.cc/150?img=4",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 5,
                    userName: "fyeo_five",
                    displayName: "User Five",
                    imageUrl: "https://i.pravatar.cc/150?img=5",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 6,
                    userName: "fyeo_six",
                    displayName: "User Six",
                    imageUrl: "https://i.pravatar.cc/150?img=6",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 7,
                    userName: "fyeo_seven",
                    displayName: "User Seven",
                    imageUrl: "https://i.pravatar.cc/150?img=7",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 8,
                    userName: "fyeo_eight",
                    displayName: "User Eight",
                    imageUrl: "https://i.pravatar.cc/150?img=8",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 9,
                    userName: "fyeo_nine",
                    displayName: "User Nine",
                    imageUrl: "https://i.pravatar.cc/150?img=9",
                    isFollowed: false
                ),
                SuggestedUser(
                    id: 10,
                    userName: "fyeo_ten",
                    displayName: "User Ten",
                    imageUrl: "https://i.pravatar.cc/150?img=10",
                    isFollowed: false
                )
            ]
    }
    
    func numberOfRows() -> Int {
        users.count
    }
    
    func user(at index: Int) -> SuggestedUser {
        users[index]
    }
    
    func followUser(at index: Int) {
        users[index].isFollowed.toggle()
    }
    
    func followAll(){
        users = users.map{
            var user = $0
            user.isFollowed = true
            return user
        }
    }
}
