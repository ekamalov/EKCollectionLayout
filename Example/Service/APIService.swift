//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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

