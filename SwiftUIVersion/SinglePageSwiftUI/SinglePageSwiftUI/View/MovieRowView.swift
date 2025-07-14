//
//  MovieRowView.swift
//  SinglePageSwiftUI
//
//  Created by Surendra Mahawar on 14/07/25.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Search

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: movie.poster ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 100)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 80, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "")
                    .font(.headline)
                Text("Year: \(movie.year ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

