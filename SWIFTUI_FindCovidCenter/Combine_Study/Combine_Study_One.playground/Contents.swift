import Foundation

import Combine

var bag = Set<AnyCancellable>()

print("PUBLISHER")
let su = [1,2,3,4,5].publisher // 시퀀스.publisher를 붙여서 publisher로 만들 수 있음
su
    .sink(receiveCompletion: { value in// 완료될 때 실행
        print("완료 \(value)")
    }, receiveValue: { value in// 새로운 값을 받아옴
        print("새로운 값 \(value)")
    })
    .store(in: &bag)

print("--------------------------------")

Just("JUST IS STRUCT")
    .sink(receiveCompletion: {
        print("완료 \($0)")
    }, receiveValue: {
        print("새로운 값 \($0)")
    })
    .store(in: &bag)

print("--------------------------------")

let future = Future<String, Error>{promise in
    promise(.success("FUTURE IS CLASS"))
}

future
    .sink(receiveCompletion: {
        print("완료 \($0)")
    }, receiveValue: { value in
        print("새로운 값 \(value)")
    })
    .store(in: &bag)

print("--------------------------------")

let deferred = Deferred{
    Just("DEFERRED IS STRUCT")
}

deferred.sink(receiveCompletion: {
    print("완료 \($0)")
}, receiveValue: { value in
    print("새로운 값 \(value)")
})
.store(in: &bag)

print("--------------------------------")

let empty = Empty<String, Error>()

empty.sink(receiveCompletion: {
    print("EMPTY IS NOT NEW VALUE \($0)")
}, receiveValue: { value in
    print("새로운 값 \(value)")
})
.store(in: &bag)

print("--------------------------------")

/*
let error = Fail<String, Error>(error: fatalError("FAIL ERROR"))

error.sink(receiveCompletion: {
    print("ERROR IS ERROR \($0)")
}, receiveValue: { value in
    print("새로운 값 \(value)")
})
.store(in: &bag)
*/

let record = Record<String, Error>(output: ["R", "E", "C", "O", "R", "D"], completion: .finished)

record.sink(receiveCompletion: {
    print("완료 \($0)")
}, receiveValue: { value in
    print("새로운 값 \(value)")
})
.store(in: &bag)

print("--------------------------------")

class Human{
    var name : String{
        didSet{
            print("NAME CHANGE \(name)")
        }
    }
    
    init(name : String){
        self.name = name
    }
}


let people = Human(name: "A")

["B", "C", "D"].publisher
    .handleEvents(receiveCompletion: {
        print("완료 \($0)")
    })
    .assign(to: \.name, on: people)
    .store(in: &bag)
