//
//  FeaturedArticleView.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/12/21.
//

import SwiftUI

enum LoadingState {
    case loading, complete, failed
}

struct FeaturedArticleView: View {
    @State private var loadingState = LoadingState.loading
    @State private var navigate = false
    @State private var article: Article?
    private let featuredArticle = "Gorditas"
    
    var body: some View {
        VStack {
            switch loadingState {
            case .loading:
                Spacer()
                Text("Loading")
                Spacer()
            case .complete:
                ArticleView(article: article!)
            case .failed:
                Text("Oh no!\nSomething went wrong\n:(")
            }
        }
        .onAppear {
            let fh = FirestoreHelper()
            fh.getArticleByName(name: featuredArticle) { loadedArticle, success in
                if success && loadedArticle != nil {
                    article = loadedArticle!
                    loadingState = .complete
                } else {
                    loadingState = .failed
                }
            }
        }
    }
}
