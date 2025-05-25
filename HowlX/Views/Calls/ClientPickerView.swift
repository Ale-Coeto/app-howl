//
//  ClientPickerView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import SwiftUI

struct ClientPickerView: View {
    @ObservedObject var vm: RecordingSheetVM
    @State private var isMenuPresented = false
    @State private var searchText = ""

    var filteredClients: [Client] {
        if searchText.isEmpty {
            return vm.clients
        } else {
            return vm.clients.filter {
                $0.firstname.localizedCaseInsensitiveContains(searchText)
                    || $0.lastname.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                isMenuPresented.toggle()
            }) {
                HStack {
                    if vm.getDisplayName(vm.selectedClient) == "" {
                        Text("Selecciona un cliente")
                            .foregroundColor(.text)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    } else {
                        Text(vm.getDisplayName(vm.selectedClient))
                            .foregroundColor(.text)
                        Spacer()
                        Text(vm.getCompanyName(vm.selectedClient))
                            .foregroundStyle(.primaryLight)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }

            if isMenuPresented {
                VStack(spacing: 0) {
                    TextField("Buscar...", text: $searchText)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding([.top, .horizontal])

                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(filteredClients, id: \.self) { client in
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
                                    .padding(.horizontal)
                                    .background(Color.white)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .frame(maxHeight: 300)  // scrollable area
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
            }
        }
        .animation(.easeInOut, value: isMenuPresented)
    }
}

#Preview {
    ClientPickerView(vm: RecordingSheetVM())
}
