//
//  APIService.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import Foundation

class APIService {
    class func fetchHitFeeds(completion:  @escaping (Result<HitFeeds,Error>) -> Void) {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "HitFeed", ofType: "json") {
                do {
                    let fileUrl = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: fileUrl)
                    let res = try JSONDecoder().decode(HitFeeds.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    class func fetchCarousel(completion:  @escaping (Result<CarouselItems,Error>) -> Void) {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "Carousel", ofType: "json") {
                do {
                    let fileUrl = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: fileUrl)
                    let res = try JSONDecoder().decode(CarouselItems.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    class func fetchGenres(completion:  @escaping (Result<Genres,Error>) -> Void) {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "Genres", ofType: "json") {
                do {
                    let fileUrl = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: fileUrl)
                    let res = try JSONDecoder().decode(Genres.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    class func fetchPersons(completion:  @escaping (Result<Persons,Error>) -> Void) {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "Persons", ofType: "json") {
                do {
                    let fileUrl = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: fileUrl)
                    let res = try JSONDecoder().decode(Persons.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

