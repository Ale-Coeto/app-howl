//
//  ClientPickerView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//
import SwiftUI

struct ClientPickerView2: View {
    @ObservedObject var vm: UploadSheetVM
    @State private var isMenuPresented = false
    @State private var searchText = ""
    
    var filteredClients: [Client] {
        if searchText.isEmpty {
            return vm.clients
        } else {
            return vm.clients.filter {
                $0.firstname.localizedCaseInsensitiveContains(searchText) ||
                $0.lastname.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 8) {
                // Main Button
                Button(action: { isMenuPresented.toggle() }) {
                    HStack {
                        if vm.getDisplayName(vm.selectedClient).isEmpty {
                            Text("Selecciona un cliente")
                                .foregroundColor(.text)
                        } else {
                            Text(vm.getDisplayName(vm.selectedClient))
                                .foregroundColor(.text)
                            Spacer()
                            Text(vm.getCompanyName(vm.selectedClient))
                                .foregroundStyle(.primaryLight)
                        }
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                // Dropdown Menu
                if isMenuPresented {
                    VStack(spacing: 0) {
                        // Search Bar
                        TextField("Buscar...", text: $searchText)
                            .padding(10)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .padding(.top, 8)
                        
                        // Clients List
                        List(filteredClients, id: \.self) { client in
                            Button(action: {
                                vm.selectedClient = client
                                isMenuPresented = false
                                searchText = ""
                            }) {
                                HStack {
                                    Text(vm.getDisplayName(client))
                                        .foregroundColor(.text)
                                    Spacer()
                                    Text(vm.getCompanyName(client))
                                        .foregroundStyle(.primaryLight)
                                }
                                .padding(.vertical, 8)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                        .frame(height: geometry.size.height * 0.6) // 60% of available height
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .transition(.move(edge: .top).animation(.easeInOut))
                }
            }
        }
        .frame(height: isMenuPresented ? 400 : 50) // Dynamic height
    }
}
//import SwiftUI
//
//struct ClientPickerView: View {
//    @ObservedObject var vm: RecordingSheetVM
//    @State private var isMenuPresented = false
//    @State private var searchText = ""
//
//    var filteredClients: [Client] {
//        if searchText.isEmpty {
//            return vm.clients
//        } else {
//            return vm.clients.filter {
//                $0.firstname.localizedCaseInsensitiveContains(searchText)
//                    || $0.lastname.localizedCaseInsensitiveContains(searchText)
//            }
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Button(action: {
//                isMenuPresented.toggle()
//            }) {
//                HStack {
//                    if vm.getDisplayName(vm.selectedClient) == "" {
//                        Text("Selecciona un cliente")
//                            .foregroundColor(.text)
//                        Spacer()
//                        Image(systemName: "chevron.down")
//                            .foregroundColor(.gray)
//                    } else {
//                        Text(vm.getDisplayName(vm.selectedClient))
//                            .foregroundColor(.text)
//                        Spacer()
//                        Text(vm.getCompanyName(vm.selectedClient))
//                            .foregroundStyle(.primaryLight)
//                        Image(systemName: "chevron.down")
//                            .foregroundColor(.gray)
//                    }
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//            }
//
//            if isMenuPresented {
//                VStack(spacing: 0) {
//                    TextField("Buscar...", text: $searchText)
//                        .padding(8)
//                        .background(Color(.systemGray5))
//                        .cornerRadius(8)
//                        .padding([.top, .horizontal])
//
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 8) {
//                            ForEach(filteredClients, id: \.self) { client in
//                                Button(action: {
//                                    vm.selectedClient = client
//                                    isMenuPresented = false
//                                    searchText = ""
//                                }) {
//                                    HStack {
//                                        Text(vm.getDisplayName(client))
//                                            .foregroundColor(.text)
//                                        Spacer()
//                                        Text(vm.getCompanyName(client))
//                                            .foregroundStyle(.primaryLight)
//                                    }
//                                    .padding(.vertical, 8)
//                                    .padding(.horizontal)
//                                    .background(Color.white)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                    }
//                    .frame(maxHeight: 300)  // scrollable area
//                }
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(radius: 4)
//            }
//        }
//        .animation(.easeInOut, value: isMenuPresented)
//    }
//}

#Preview {
    ClientPickerView2(vm: UploadSheetVM())
}
