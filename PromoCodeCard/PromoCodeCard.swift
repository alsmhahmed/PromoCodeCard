//
//  PromoCodeCard.swift
//  PromoCodeCard
//
//  Created by alsmh ahmed on 23/01/2025.
//

import SwiftUI

struct PromoCodeDataSource {
    enum Status {
        case active, notActivated, notApplied, used
        
        var buttonTitle: String? {
            switch self {
            case .active:
                return nil
            case .notActivated:
                return "Activate"
            case .notApplied:
                return "Apply"
            case .used:
                return nil
            }
        }
        
        var statusText: String? {
            switch self {
            case .active:
                return "Active"
            case .used:
                return "Used"
            default:
                return nil
            }
        }
        
        var statusIcon: Image? {
            switch self {
            case .active, .used:
                return Image(systemName: "checkmark")
            default:
                return nil
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .active:
                return Color.blue.opacity(0.8)
            case .notActivated:
                return Color.gray.opacity(0.8)
            case .notApplied:
                return Color.cyan.opacity(0.8)
            case .used:
                return Color.gray.opacity(0.1)
            }
        }
        
        var textColor: Color {
            switch self {
            case .used:
                return .black
            default:
                return .white
            }
        }
    }
    
    var title: String
    var description: String
    var expiryDate: String
    var status: Status
}

struct PromoCodeCard: View {
    var datasource: PromoCodeDataSource
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                // Title
                Text(datasource.title)
                    .font(.headline)
                    .foregroundColor(datasource.status.textColor)
                VStack(alignment:.leading,spacing:16){
                    
                    // Description
                    Text(datasource.description)
                        .font(.subheadline)
                        .foregroundColor(datasource.status.textColor.opacity(0.7))
                    
                    Divider()
                        .background(datasource.status.textColor.opacity(0.5))
                    
                    // Expiry Date
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(datasource.status.textColor.opacity(0.7))
                        Text(datasource.expiryDate)
                            .font(.footnote)
                            .foregroundColor(datasource.status.textColor.opacity(0.7))
                        
                        
                        Spacer()
                        
                        // Status or Button
                        if let statusText = datasource.status.statusText,
                           let icon = datasource.status.statusIcon {
                            HStack(spacing: 4) {
                                icon
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(datasource.status.textColor)
                                Text(statusText)
                                    .font(.footnote)
                                    .foregroundColor(datasource.status.textColor)
                            }
                        } else if let buttonTitle = datasource.status.buttonTitle {
                            Button(action: {
                                print("\(buttonTitle) button tapped")
                            }) {
                                Text(buttonTitle)
                                    .font(.footnote.bold())
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(datasource.status.textColor)
                                    .foregroundColor(datasource.status.backgroundColor)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                
                
            }
        }
        .padding()
        .background(datasource.status.backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(datasource.status == .used ? Color.gray.opacity(0.4) : Color.clear, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 16) {
        PromoCodeCard(datasource: PromoCodeDataSource(
            title: "Title",
            description: "Description",
            expiryDate: "Expire date",
            status: .active
        ))
        
        PromoCodeCard(datasource: PromoCodeDataSource(
            title: "Title",
            description: "Description",
            expiryDate: "Expire date",
            status: .notActivated
        ))
        
        PromoCodeCard(datasource: PromoCodeDataSource(
            title: "Title",
            description: "Description",
            expiryDate: "Expire date",
            status: .notApplied
        ))
        
        PromoCodeCard(datasource: PromoCodeDataSource(
            title: "Title",
            description: "Description",
            expiryDate: "Expire date",
            status: .used
        ))
    }
    .previewLayout(.sizeThatFits)
}

