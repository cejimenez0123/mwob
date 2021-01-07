//
//  ContentView.swift
//  mwob
//
//  Created by /fam on 1/6/21.
//

import SwiftUI

struct GridStack<Content:View>:View{
    let rows: Int
    let columns: Int
    let content: (Int,Int)->Content
    var body: some View{
        VStack{
            ForEach(0..<self.columns){col in
                HStack{
                    ForEach(0..<self.rows){row in
                        self.content(row,col)
                    }
                }
            }
        }
        
    }
    
    
}

struct ContentView: View {
    var body: some View {
        
            
           GridStack(rows: 4, columns: 3) {row,col in
            VStack{
                
            Text("(\(row),\(col))")
            }
           }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
