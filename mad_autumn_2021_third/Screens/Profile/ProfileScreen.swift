//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import SwiftUIFlowLayout
import SwiftDate
import MediaSwiftUI
import MediaCore

struct ProfileScreen: View {
    
    @StateObject var vm: ProfileScreenModel
    
    @State var picker = false
    
    @State var browser = false
    
    @Binding var open: Bool

    @ViewBuilder
    var avatar: some View {
        ZStack {
            Image("avatarBg").resizable().height(150).width(150)
            Group {
                if let selected = vm.selectedAvatarData, let img = Image(data: selected) {
                    img.resizable()
                } else {
                    AvatarView(url: vm.profile?.avatar)
                }
            }.height(112).width(112).clipCircle()
        }
    }
    
    var browserView: some View {
        Photo.browser(isPresented: $browser, selectionLimit: 1, vm.didSelectPhoto)
    }
    
    var body: some View {
            ZStack(alignment: .top) {
                Rectangle().fill(Color.background).ignoresSafeArea()
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Text("Why are you scary?").font(.subtitle).maxWidth(.infinity)
                        
                        ZStack {
                            avatar.onTapGesture {
                                if Media.currentPermission != .authorized {
                                    Media.requestPermission { res in
                                        if let _ = try? res.get() {
                                            browser = true
                                        }
                                    }
                                } else {
                                    browser = true
                                }
                                
                            }
                        }.maxWidth(.infinity).fullScreenCover(isPresented: $browser, onDismiss: { browser = false }, content: {
                            browserView
                        })
                        
                        
                        
                        MyTextField("Name", text: $vm.profile.withDefaultValue(.init()).map(\.name), .emailAddress)
                        MyTextField("About", text: $vm.profile.withDefaultValue(.init()).map(\.aboutMyself).withDefaultValue(""), nil, multiline: true)
                        
                        Text("Party Topics").font(.plain).maxWidth(.infinity)
                        
                        if !vm.topics.isEmpty {
                            SwiftUIFlowLayout.FlowLayout(mode: .scrollable, items: vm.topics, itemSpacing: 4) { topic in
                                let isSelected = vm.isSelected(topic)
                                Text(topic.title).font(.tags).padding(.horizontal, 8).foregroundColor(isSelected ? .black : .orange).height(25).background(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.orange, lineWidth: 1).background(RoundedRectangle(cornerRadius: 12).fill(isSelected ? Color.orange : Color.clear))).onTapGesture {
                                    vm.toggleTopic(topic)
                                }
                            }
                        }

                        Text("Party Date").font(.plain).maxWidth(.infinity)
                        
                        if picker {
                            Button(vm.date.toFormat("dd MMMM YYYY - HH:mm")) {
                                picker = false
                            }.buttonStyle(BS.underlined)
                            
                            DatePicker("Date", selection: $vm.date).datePickerStyle(.graphical).background(.background)
                        } else {
                            Button("Select Date and Time") {
                                picker = true
                            }.buttonStyle(BS.underlined)
                        }
                        
                        Spacer(minLength: 60)
                    }.padding(.horizontal, 21)
                }.overlay(alignment: .bottom) {
                    Button("Save") {
                        vm.save { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                open = false
                            }
                        }
                        
                    }.buttonStyle(BS.general).padding(.horizontal, 21)
                }
                
            }.navigationBarHidden(true)
            
        
    }
}

//struct ProfileScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileScreen(vm: .init(.init()))
//    }
//}
