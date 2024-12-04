
import SwiftUI
import AVKit










struct EquipmentDetail: View {

    @AppStorage("overlay") private var overlayHide = false
    @EnvironmentObject var modelData: ModelData
    @AppStorage("ipAddress") private var ipAddress = ""
    @AppStorage("port") private var port = ""
    @AppStorage("darkmode") var darkMode = false
    var equipmentIndex: Int {
        modelData.equipment.firstIndex(where: {$0.id == equipment.id})!
    }

    
    var equipment : Equipment
    var body: some View {
        
        
        
        GeometryReader { geo in
            ZStack {
                 
                if UIDevice.current.orientation.isLandscape {
                    Color.black
                }
                 
                VStack {
                    
                    player(equipment: equipment).frame(height: UIDevice.current.orientation.isLandscape ? geo.size.height : geo.size.height)
                        
                   
                   
                         
                         
                }
            }
        }            .navigationBarItems(trailing:
                                            
                                            Button("Show Info") {
                                            overlayHide.toggle()
                                                
                                            }
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .topTrailing)
                                            .padding(.trailing)
                                        ).navigationTitle(equipment.name).sheet(isPresented: $overlayHide) {
            SynopsisView(isSet:  $modelData.equipment[equipmentIndex].isFavorite, equipment: equipment).environment(\.colorScheme, darkMode ? .dark : .light)

        }
    

            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                setAudioSessionCategory(to: .playback)
                AVPlayer(url: URL(string: ipAddress + ":" + port + "/" + equipment.videourl)!).play()
            }
            .onDisappear {
                AVPlayer(url: URL(string: ipAddress + ":" + port + "/" + equipment.videourl)!).pause()
            }
    }
        
                

               
                
           
        
        
   
        
        
        
        
        }
func setAudioSessionCategory(to value: AVAudioSession.Category) {
    let audioSession = AVAudioSession.sharedInstance()
         do {
            try audioSession.setCategory(value)
         } catch {
             print("Setting category to AVAudioSessionCategoryPlayback failed.")
         }
}
struct player : UIViewControllerRepresentable {
    @AppStorage("ipAddress") private var ipAddress = ""
    @AppStorage("port") private var port = ""
    @AppStorage("overlay") private var overlayHide = false
    @EnvironmentObject var modelData: ModelData
    var equipmentIndex: Int {
        modelData.equipment.firstIndex(where: {$0.id == equipment.id})!
    }

    
    var equipment : Equipment
    
    

    
    func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
         
        let player1 = AVPlayer(url: URL(string: ipAddress + ":" + port + "/" + equipment.videourl)!)
        
        
        // Setting content external metadata
        let titleItem = AVMutableMetadataItem()
        titleItem.identifier = .commonIdentifierTitle
        titleItem.value = String(equipment.name) as (any NSCopying & NSObjectProtocol)?
        
        
        let infoItem = AVMutableMetadataItem()
        infoItem.identifier = .commonIdentifierDescription
        infoItem.value = String(equipment.synopsis) as (any NSCopying & NSObjectProtocol)?
        
        player1.currentItem?.externalMetadata = [titleItem, infoItem]

        
        let controller = AVPlayerViewController()
        controller.player = player1

        return controller

        
  
        
    }
     
    func updateUIViewController(_ uiViewController : AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
         
         
    }
   
   

    
   
}



