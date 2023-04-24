import SwiftUI
import PlaygroundSupport
import Foundation

struct ContentView: View {
    @State private var login : Bool = false
    @State private var idValue : String = ""
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Toggle("LOGIN?", isOn: $login)
                .padding()
            IDView(login: $login, idValue: $idValue)
                .padding()
            Button("PW RESET"){
                self.viewModel.valueChange(id: self.idValue)
            }
            .disabled(!self.login)
            
            if login{
                Text(self.viewModel.value)
            }
        }
        .padding()
        
    }
}

struct IDView : View{
    @Binding var login : Bool
    @Binding var idValue : String
    
    var body : some View{
        TextField("ID", text: $idValue)
            .disabled(!login)
    }
}

class ViewModel : ObservableObject{
    @Published var value : String = "abc123"
    
    func valueChange(id : String){
        self.value = "\(id)\(["zzz123", "000", "999"].randomElement()!)"
    }
}


PlaygroundPage.current.setLiveView(ContentView())
