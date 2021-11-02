//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import SwiftDate

struct ProfileScreen: View {
    
    @StateObject var vm: ProfileScreenModel
    
    @State var date: Date = .init()
    @State var picker = false
    
    func save() {
        vm.party = DateInRegion(date).toISO()
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle().ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Party Date").font(.plain).fontSize(16).foregroundColor(.white)
                    
                    if picker {
                        Button(date.toFormat("dd MMMM YYYY - HH:mm")) {
                            picker = false
                        }.buttonStyle(BS.underlined)
                        
                        DatePicker("Date", selection: $date).datePickerStyle(.graphical).background(.white)
                    } else {
                        Button("Select Date and Time") {
                            picker = true
                        }.buttonStyle(BS.underlined)
                    }
                    
                    Button("Save") {
                        save()
                    }.buttonStyle(BS.general)
                }.padding(.horizontal, 21)
                MyActivityIndicator(isLoading: vm.isLoading)
            }.navigationBarHidden(true)
            
        }
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
