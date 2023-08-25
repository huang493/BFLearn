//
//  CombineLL.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/23.
//

import Foundation
import Combine

enum SampleError: Error {
    case sampleError
}

enum MyError: Error {
    case myError
}

public func check<P: Publisher>(_ title: String, publisher: ()->P) -> AnyCancellable {
    print(">>>>>>>>>\(title)<<<<<<<")
    defer {
        print("")
    }
    return publisher().print().sink { _ in
        print("x")
    } receiveValue: { _ in
        print("o")
    }
}

public func delay(_ t: UInt32, _ action: ()->Void) {
    sleep(t)
    action()
}

class CombineDemo {
    class func action() {
        print("combine demo")
        
        
        subject()
//        publisherAndOperator()
        
    }
    
    class func subject() {
        let subject_example1 = PassthroughSubject<Int, Never>()
        let subject_example2 = PassthroughSubject<Int, Never>()

        check("Subject Order") {
            subject_example1.merge(with: subject_example2)
        }

        subject_example1.send(20)
        subject_example2.send(1)
        subject_example1.send(40)
        subject_example1.send(60)
        subject_example2.send(1)
        subject_example1.send(80)
        subject_example1.send(100)
        subject_example1.send(completion: .finished)
        subject_example2.send(completion: .finished)

    }
    
    class func publisherAndOperator() {
        // Publishers
        _ = check("Empty") {
            return Empty<Int, Never>()
        }
        
        _ = check("Just", publisher: {
            return Just(1)
        })
        
        _ = check("Sequence", publisher: {
            return Publishers.Sequence<[Int], Never>(sequence: [1,2,3,4])
        })
        
        _ = check("easy sequence", publisher: {
            return [1,2,3,4].publisher
        })
        
        //Operator
        _ = check("map", publisher: {
            return [1,2,3,4].publisher.map { i in
                i * i
            }
        })
        
        _ = check("filter", publisher: {
            return [1, 2, 3, 4].publisher.filter { $0 % 2 == 0}
        })
        
        _ = check("contains", publisher: {
            return [1, 2, 3, 4].publisher.contains(2)
        })
        
        _ = check("reduce", publisher: {
            return [1,2,3,4].publisher.reduce(0) { i, p in
                return p + i
            }
        })
        
        _ = check("compact map", publisher: {
            return ["1", "2", "xx", "3"].publisher
                .compactMap { Int($0) }
        })
        
        
        _ = check("flat map", publisher: {
            return [[1,2,3,4], ["a","b","c",]].publisher.flatMap { $0.publisher }
        })
        
        _ = check("remove deplicates", publisher: {
            return [1,2,3,3,3,4,5].publisher.removeDuplicates()
        })
        
        //错误处理：
        _ = check("error", publisher: {
            return Fail<Int, SampleError>(error: SampleError.sampleError)
        })
        
        _ = check("map error", publisher: {
            return Fail<Int, SampleError>(error: .sampleError).mapError { e in
                return MyError.myError
            }
        })
        
        _ = check("throw error", publisher: {
            return ["1","2","cat","3"].publisher.tryMap { s in
                guard let i = Int(s) else {
                    throw SampleError.sampleError
                }
                return i
            }
        })
        
        _ = check("replace error", publisher: {
            return ["1","2","cat","3"].publisher.tryMap { s in
                guard let i = Int(s) else {
                    throw SampleError.sampleError
                }
                return i
            }.replaceError(with: -1)
        })
        
        _ = check("replace error", publisher: {
            return ["1","2","cat","3"].publisher.tryMap { s in
                guard let i = Int(s) else {
                    throw SampleError.sampleError
                }
                return i
            }.catch { _ in
                return Just(-2)
            }
        })
        
        /*
            类型消除
            原因：链式调用导致的一堆嵌套
            解决：eraseToAnyPublisher()
         */
        
        
    }
}
