import SwiftUI



struct ContentView: View {

    @State private var showAlert = false

    @State private var tap = false

    @State private var currentIndex = 0
    
   
    

    var body: some View {

        ZStack {

            Image("BG")

                .resizable()

                .scaledToFill()

                .edgesIgnoringSafeArea(.all)

            

            ZStack{

                Color.gray.opacity(0.6)

                    .frame(width: 450, height:250)

                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))

                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)

                    .blur(radius: 2)

                

                VStack(alignment: .center, spacing: 50) {

                    Text("SOFTWARE UPDATE AVAILABLE!")
                        .font(Font.custom("Cinzel", size: 25))
                        
                        .foregroundColor(Color.black.opacity(1))

                        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in

                            NSApp.mainWindow?.standardWindowButton(.zoomButton)?.isHidden = true

                            NSApp.mainWindow?.standardWindowButton(.closeButton)?.isHidden = true

                            NSApp.mainWindow?.standardWindowButton(.miniaturizeButton)?.isHidden = true

                        }

                    let imageNames = ["tc", "applee"]

                    HStack {
                    
                                   Spacer()
                        Image(imageNames[currentIndex])
                    
                                       .resizable()
                                       .frame(width: 60, height: 60)
                                       .animation(.default)

                                   Spacer()

                               }
                               .onAppear {
                                   Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                                       currentIndex = (currentIndex + 1) % imageNames.count
                                   }
                                
                               }
                    
                    }
                    
                    .padding(.bottom, 70)

                    

                    HStack(spacing: 10) {
                            
                        Button(action: {

                            // Action for DEFER button

                            NSApplication.shared.windows.first?.miniaturize(self)

                            DispatchQueue.main.asyncAfter(deadline: .now() + 300) {

                                NSApplication.shared.windows.first?.deminiaturize(self)

                            }

                        }) {

                            Text("DEFER")

                                .foregroundColor(.white)

                        }

                        .buttonStyle(CustomButtonStyle())

                        

                        Button(action: {

                            // Action for INFO button

                            if let url = URL(string: "https://www.apple.com/in/newsroom/2023/09/macos-sonoma-is-available-today/") {

                                NSWorkspace.shared.open(url)

                            }

                        }) {

                            Text("INFO")

                                .foregroundColor(.white)

                        }

                        .buttonStyle(CustomButtonStyle())

                        

                        Button(action: {

                            // Action for BACKUP button

                            self.showAlert = true

                        }) {

                            Text("BACKUP")

                                .foregroundColor(.white)

                        }

                        .buttonStyle(CustomButtonStyle())
                        .alert(isPresented: $showAlert) {

                            Alert(

                                title: Text("To Proceed with Update kindly Backup your important data->Steps to Back-UP 1.Make a Backup Folder and copy all important Data to this folder2.Upload this folder to Gmail Drive/iCloud Drive Or Hard Disk/Pendrive"),

                                dismissButton: .default(Text("OK"))

                    

                            )

                        }
                        

                        Button(action: {

                            // Open Google Form

                            if let url = URL(string: "https://docs.google.com/forms/d/e/your_form_link_here") {

                                NSWorkspace.shared.open(url)

                            }

                        }) {

                            Text("UPDATE")

                                .foregroundColor(.white)

                        }

                        .buttonStyle(CustomButtonStyle())

                    }
                    .padding(.top, 170)
                }

            }
        .onAppear {

            Timer.scheduledTimer(withTimeInterval: 36000, repeats: true) { timer in

                NSApplication.shared.windows.first?.makeKeyAndOrderFront(nil)

            }

        }

       

        }

       

    }








struct CustomButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        configuration.label

            .padding(.vertical, 8)

            .padding(.horizontal, 20)

            .background(

                RoundedRectangle(cornerRadius: 30)

                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color(.blue)]), startPoint: .topLeading, endPoint: .bottomTrailing))

                    .shadow(color: Color.blue.opacity(configuration.isPressed ? 0.6 : 0.3), radius: configuration.isPressed ? 10 : 20, x: 0, y: configuration.isPressed ? 5 : 10)

            )

            .scaleEffect(configuration.isPressed ? 1.2 : 1)

            .animation(.spring(response: 0.4, dampingFraction: 0.6))

    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }

}



