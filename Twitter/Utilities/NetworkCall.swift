//
//  NetworkCall.swift
//  Twitter
//
//  Created by Mark on 18/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation
import Firebase

struct NetworkCall {
    
    fileprivate let database = Firestore.firestore()
    
    func addData<T: Encodable>(to encodableObject: T, in subCollection: String) {
        
        do {
            let json = try encodableObject.toJson(excluding: ["id"])
            database.collection(subCollection).addDocument(data: json) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func read<T: Decodable>(collection: String, returning objectType: T.Type, completion: @escaping ([T]) -> ()) {
        
        database.collection(collection).getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                guard let snapshot = querySnapshot else { return }
                
                do {
                    var objects = [T]()
                    
                    for document in snapshot.documents {
                        let object = try document.decode(as: objectType.self)
                        objects.append(object)
                    }
                    
                    completion(objects)
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            }
        }
        
    }
    
    func update<T: Encodable & Identifiable>(document encodableObject: T?, in subCollection: String) {
        
        do {
            
            let json = try encodableObject.toJson(excluding: ["id"])
            
            guard case let id as String = encodableObject?.id else { throw MyError.encodingError }
            
            database.collection(subCollection).document(id).updateData(json)
            
        } catch {
            print(error)
        }
        
    }
    
    func delete<T: Identifiable>(document identifiableObject: T?, in subCollection: String) {
        do {
            
            guard case let id as String = identifiableObject?.id else { throw MyError.encodingError }
            
            database.document(id).delete()
            
        } catch {
            print(error)
        }
    }
    
    
}
