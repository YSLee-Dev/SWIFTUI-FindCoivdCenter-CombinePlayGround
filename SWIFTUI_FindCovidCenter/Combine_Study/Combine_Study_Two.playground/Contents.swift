import Foundation
import Combine

var bag = Set<AnyCancellable>()

print("PassThroughSubject")
let pass = PassthroughSubject<String, Error>()
pass.send("A")

pass
    .sink(receiveCompletion: {
        print("1완료 \($0)")
    }, receiveValue: {
        print("1: \($0)")
    })
    .store(in: &bag)

pass.send("B")

pass
    .sink(receiveCompletion: {
        print("2완료 \($0)")
    }, receiveValue: {
        print("2: \($0)")
    })
    .store(in: &bag)

pass.send("C")
pass.send("D")

// pass.send(completion: .failure(fatalError("ERROR")))
pass.send(completion: .finished)

print("----------------------")

print("CurrentValueSubject")
let value = CurrentValueSubject<String, Error>("훈민정음")

value
    .sink(receiveCompletion: {
        print("1완료 \($0)")
    }, receiveValue: {
        print("1: \($0)")
    })
    .store(in: &bag)

value.send("가")
value.send("나")

value
    .sink(receiveCompletion: {
        print("2완료 \($0)")
    }, receiveValue: {
        print("2: \($0)")
    })
    .store(in: &bag)

value.send("다")

print(value.value)
value.value = "라"

value.send(completion: .finished)
