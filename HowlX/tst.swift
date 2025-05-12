//
//  tst.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import SwiftUI

struct tst: View {
    @State private var showFileImporter = false
//         var onTemplatesDirectoryPicked: (URL) -> Void

         var body: some View {
             Button {
                 showFileImporter = true
             } label: {
                 Label("Choose templates directory", systemImage: "folder.circle")
             }
             .fileImporter(
                 isPresented: $showFileImporter,
                 allowedContentTypes: [.directory]
             ) { result in
                  switch result {
                  case .success(let directory):
                      // gain access to the directory
                      let gotAccess = directory.startAccessingSecurityScopedResource()
                      if !gotAccess { return }
                      // access the directory URL
                      // (read templates in the directory, make a bookmark, etc.)
//                      onTemplatesDirectoryPicked(directory)
                      // release access
                      directory.stopAccessingSecurityScopedResource()
                  case .failure(let error):
                      // handle error
                      print(error)
                  }
             }
         }
}

#Preview {
    tst()
}
