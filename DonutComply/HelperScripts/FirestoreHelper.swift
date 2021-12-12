//
//  FirestoreHelper.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/12/21.
//

import Foundation
import FirebaseFirestore

struct FirestoreHelper {
    
    
    func getArticleByName(name: String, completionHandler: @escaping (Article?, Bool) -> Void) {
        var attempts = 0
        
        while attempts < 4 {
            exponentialBackoff(attempts: UInt64(attempts)) {
                Firestore.firestore().collection("articles").whereField("food", isEqualTo: name).getDocuments { querySnapshot, err in
                    if let err = err {
                        // FAIL
                        print(err.localizedDescription)
                        attempts += 1
                        return
                    }
                    
                    let data = querySnapshot?.documents[0]

                    if data != nil {
                            completionHandler(Article(
                                continent: data?["continent"] as? String ?? "",
                                city: data?["city"] as? String ?? "",
                                food: data?["food"] as? String ?? "",
                                image: data?["image"] as? String ?? "",
                                context: data?["context"] as? String ?? "",
                                lat: data?["lat"] as? Double ?? 0.0,
                                lon: data?["lon"] as? Double ?? 0.0,
                                score: data?["score"] as? Int ?? 0,
                                views: data?["views"] as? Int ?? 0,
                                prepTime: data?["prepTime"] as? String ?? "",
                                cookingTime: data?["cookingTime"] as? String ?? "",
                                ingredients: data?["ingredients"] as? [String] ?? [""],
                                steps: data?["steps"] as? String ?? ""
                            ), true)
                        
                    } else {
                        print("Data was nil!")
                        attempts += 1
                        return
                    }
                }
            }
        }
        
        if attempts > 5 {
            // :(
            completionHandler(nil, false)
        }
    }
    
    func exponentialBackoff(attempts: UInt64 = 0, task: @escaping () -> Void) {
        // y = 2x + 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + Double((attempts)) * 2, execute: task)
    }
}
