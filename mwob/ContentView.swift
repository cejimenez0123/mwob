//
//  ContentView.swift
//  mwob
//
//  Created by /fam on 1/6/21.
//

import SwiftUI
struct BlueAndBold:ViewModifier{
    
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
                    content
                        Text(text)
                        .font(.headline).bold()
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                }
    }
}
extension View {
    func blueAndBold( text: String)->some View{
        self.modifier(BlueAndBold(text: text))
    }
}
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



struct ItemView:View{
    @Environment(\.presentationMode) var presentationMode
    @State var name = ""
    @State var price = 0.0
    var body: some View{
        
        Button("Dismiss"){
            self.presentationMode.wrappedValue.dismiss()
        }
        }
    
}
struct Item: Identifiable,Codable{
    var id = UUID()
    let name: String
    let images:[String]
    let price: String
}
class Basket: ObservableObject{
    
    @Published var items=[Item](){
    didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.items){
                
                UserDefaults.standard.set(encoded,forKey: "items")
            }
        }
            
        }
        init(){
            if let items = UserDefaults.standard.data(forKey: "items"){
            let decoder = JSONDecoder()
            if let decoded = try?
                decoder.decode([Item].self, from: items){
                self.items = decoded
            return
            }
           
            }
    
        }
    
}
    

struct ContentView: View {
    @State private var showItem = false
    var body: some View {
        NavigationView{
            VStack{
                Text("XO")
                .blueAndBold(text: "Charm")
                HStack{
            
        
                GridStack(rows: 2, columns: 5) {row,col in
                    VStack{
                        Button("Tap Me"){
                            showItem.toggle()
                        }.sheet(isPresented: $showItem, content: {
                            ItemView(name:"Widget",price: 2.0)
                        })
                        }
//                    Text("(\(row),\(col))")
                        .padding(15)
                        
            }
           }
        
        }
                
        }
            
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
