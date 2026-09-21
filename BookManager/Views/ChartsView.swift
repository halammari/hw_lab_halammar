import SwiftUI
import Charts

struct ChartsView: View {
    
    @EnvironmentObject var library: Library
    
    var body: some View {
        VStack {
            
            Text("Books by Author Gender")
                .font(.headline)
            
            Chart {
                BarMark(
                    x: .value("Gender", "Male"),
                    y: .value(
                        "Books",
                        library.getMaleAuthoredBooks().count
                    )
                )
                
                BarMark(
                    x: .value("Gender", "Female"),
                    y: .value(
                        "Books",
                        library.getFemaleAuthoredBooks().count
                    )
                )
            }
            .frame(height: 250)
            .padding(20)
            
            Spacer()
            
            Text("Books by Popular Authors")
                .font(.headline)
            
            Chart {
                BarMark(
                    x: .value("Author", "William Shakespeare"),
                    y: .value(
                        "Books",
                        library.getBooksFor("William Shakespeare").count
                    )
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Jane Austen"),
                    y: .value(
                        "Books",
                        library.getBooksFor("Jane Austen").count
                    )
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "J.R.R. Tolkien"),
                    y: .value(
                        "Books",
                        library.getBooksFor("J.R.R. Tolkien").count
                    )
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Charles Dickens"),
                    y: .value(
                        "Books",
                        library.getBooksFor("Charles Dickens").count
                    )
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Charlotte Bronte"),
                    y: .value(
                        "Books",
                        library.getBooksFor("Charlotte Bronte").count
                    )
                )
                .foregroundStyle(.green)
            }
            .frame(height: 250)
            .padding(20)
        }
        .padding()
    }
}
