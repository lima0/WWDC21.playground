import Foundation
import SwiftUI

public struct MainView: View {
    public init() {}
    @State private var isInternetSheetDisplayed = false
    @State private var isPacketsSheetDisplayed = false
    @State private var isLayersSheetDisplayed = false
    public var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("The Internet")
                .bold()
                .padding(.bottom, 10)
                .foregroundColor(Color(red: 236/255, green: 239/255, blue: 244/255))
            
            Text("The internet can be split into layers\n using a conceptual model called the OSI model")
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 236/255, green: 239/255, blue: 244/255))
            
            Spacer()
            
            Button(action: {
                self.isInternetSheetDisplayed.toggle()
            }, label: {
                Text("Introduction")
                    .frame(width: 200, height: 100, alignment: .center)
                    .foregroundColor(Color(red: 216/255, green: 222/255, blue: 233/255))
                    .font(Font.body.weight(.bold))
            })
            .background(Color(red: 136/255, green: 192/255, blue: 208/255))
            .cornerRadius(20)
            .sheet(isPresented: $isInternetSheetDisplayed, content: {
                IntroductionView()
            })
            
            Button(action: {
                self.isPacketsSheetDisplayed.toggle()
            }, label: {
                Text("Packets and Protocols")
                    .frame(width: 200, height: 100, alignment: .center)
                    .foregroundColor(Color(red: 216/255, green: 222/255, blue: 233/255))
                    .font(Font.body.weight(.bold))
            })
            .background(Color(red: 136/255, green: 192/255, blue: 208/255))
            .cornerRadius(20)
            .sheet(isPresented: $isPacketsSheetDisplayed, content: {
                PacketsAndProtocolsView()
            })
            
            Button(action: {
                self.isLayersSheetDisplayed.toggle()
            }, label: {
                Text("OSI Model")
                    .frame(width: 200, height: 100, alignment: .center)
                    .foregroundColor(Color(red: 216/255, green: 222/255, blue: 233/255))
                    .font(Font.body.weight(.bold))
            })
            .background(Color(red: 136/255, green: 192/255, blue: 208/255))
            .cornerRadius(20)
            .sheet(isPresented: $isLayersSheetDisplayed, content: {
                NetworkLayersView()
            })
            Spacer()
            
            Text("If you're done reading, go to the next page :)")
                .foregroundColor(Color(red: 236/255, green: 239/255, blue: 244/255))
        }
        .frame(minWidth: 400, idealWidth: 400, maxWidth: .infinity, minHeight: 500, idealHeight: 500, maxHeight: .infinity, alignment: .center)
        .padding(10)
        .background(Color(red: 46/255, green: 52/255, blue: 64/255))
    }
}

public struct IntroductionView: View {
    @Environment(\.presentationMode) var presentationMode
    public var body: some View {
        Text("""
            What is the internet:
            The internet is the system of interconnected computer networks that use the TCP/IP suite of protocols to communicate together.
            All systems use protocols to define the "language" they communicate with together. Those are usually created by the Internet Engineering Task Force and are called RFCs
            Messages sent across computers are split in packets and sent using these protocols
            """)
            .padding(10)
        Button("Close") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct PacketsAndProtocolsView: View {
    @Environment(\.presentationMode) var presentationMode
    public var body: some View {
        Text("""
            Packets and Protocols:
            A message sent across the internet is usually split into packets due to physical ethernet limitations, those packets use a defined protocol called IP (Internet Protocol)
            Packets also use TCP or UDP (sockets use TCP most of the time), TCP checks the data and reorders it if needed due to the possibility of packets arriving unordered.
            """)
            .padding(10)
        Button("Close") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct NetworkLayersView: View {
    @Environment(\.presentationMode) var presentationMode
    public var body: some View {
        Text("""
            The internet can be split into conceptual layers using a model called the OSI model.
            Layer 7: Application layer (what the user sees)
            Layer 6: Presentation layer (how the data is presented)
            Layer 5: Session layer (maintains the session/socket)
            Layer 4: Transport layer (connection reliability)
            Layer 3: Network layer (routing and addressing)
            Layer 2: Data link layer (physical addressing)
            Layer 1: Physical layer (cables, Wi-Fi etc.)
            """)
        Button("Close") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

