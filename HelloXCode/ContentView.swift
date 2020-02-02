//
//  ContentView.swift
//  HelloXCode
//
//  Created by Abhishek on 1/27/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import SwiftUI
import Contacts

struct ContentView: View {
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State var showAlert = false
    
    var body: some View {
        VStack{
            ProfileImageView()
            Text("Contact Details!")
                .accentColor(Color.blue)
                .font(.title)
            HStack{
                Text("Name")
                Spacer()
                TextField("Enter Name:", text: $name)
                    .background(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/)
            }.padding()
            HStack{
                Text("Phone")
                Spacer()
                TextField("Enter Name:", text: $phone)
                    .background(Color.gray)
            }.padding()
            HStack{
                Spacer()
            }
            HStack{
                Button(action: {
                    onSaveContact(name:self.name, phone:self.phone)
                }){
                    Image(systemName: "plus.circle")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .clipShape(Circle())
                }
                Spacer()
                Button(action:{
                    onDeleteContact(name:self.name)
                }){
                Image(systemName: "minus.circle")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Circle())
                    }
                }
        }.padding()
        
    }
    
}

func onSaveContact(name:String , phone: String){
    print("Add button clicked!")
    saveContact(name:name, phone:phone)
}

func onDeleteContact(name: String){
    print ("Delete button clicked!")
    deleteContact(name: name)
}

func deleteContact(name: String){
    let store = CNContactStore()
     
     let predicate = CNContact.predicateForContacts(matchingName:name)
     
     let keysToFetch = [ CNContactPhoneNumbersKey as CNKeyDescriptor]
     do{
     let contacts = try store.unifiedContacts( matching: predicate, keysToFetch: keysToFetch)
     
         if contacts.count > 0 {
             print("contacts found")
             let mutableContact = contacts[0].mutableCopy() as! CNMutableContact
             let req = CNSaveRequest()
             req.delete(mutableContact)

             do{
               try store.execute(req)
               print("Success, You deleted the user: ", name)
             } catch let e{
               print("Error = \(e)")
             }
             
         } else{
             print("No contacts found")
         }
     } catch let err {
         print(err)
     }
}

func saveContact(name: String, phone: String){
    let store = CNContactStore()
    
    
    let predicate = CNContact.predicateForContacts(matchingName:name)
    let keysToFetch = [ CNContactPhoneNumbersKey as CNKeyDescriptor]
    
    do{
    let contacts = try store.unifiedContacts( matching: predicate, keysToFetch: keysToFetch)
    
        if contacts.count > 0 {
            print("contacts found, No duplicate contact allowed")
        } else {
                let contactData = CNMutableContact()
                    contactData.givenName = name
               
                let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: phone))
                    contactData.phoneNumbers = [homePhone]
          
            
            let imageName: String = "icon.png"
            let image = UIImage(named: imageName)
            
                if image != nil {
                    contactData.imageData = image!.pngData();
                }
            
                let saveRequest = CNSaveRequest()
                saveRequest.add(contactData, toContainerWithIdentifier: nil)
               
               do{
                  try! store.execute(saveRequest)
                   print("Successfully added the contact: " + name)
                }
        }
    } catch let err {
        print(err)
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
