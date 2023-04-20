import Foundation
import Combine

var bag = Set<AnyCancellable>()

print("Prepending")
[1,2,3,4,5,6].publisher
    .prepend(0)
    .prepend([-2, -1])
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

print("--------------------------")

let ganada = PassthroughSubject<String, Never>()
let abc = ["a", "b", "c"].publisher

abc
    .prepend(ganada)
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

ganada
    .send("가")
ganada
    .send("나")
ganada
    .send("다")

ganada.send(completion: .finished)

print("--------------------------")

print("Appending")
[1,2,3,4,5,6].publisher
    .append([7,8,9])
    .append(10)
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

print("--------------------------")

let name_first = PassthroughSubject<String, Never>()
let name_last = Just("C")

name_first
    .append(name_last)
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

name_first
    .send("A")
name_first
    .send("B")
name_first
    .send(completion: .finished)

print("--------------------------")
print("SwitchToLatest")

let subjects = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()

let subjectA = PassthroughSubject<Int, Never>()
let subjectB = PassthroughSubject<Int, Never>()

subjects
    .switchToLatest()
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

subjects.send(subjectA)
subjectA.send(0)
subjectA.send(1)

subjects.send(subjectB)
subjectA.send(2)
subjectB.send(100)
subjectB.send(200)
subjects.send(completion: .finished)

subjectB.send(completion: .finished)

print("--------------------------")
print("Merge")

let randomSu1 = [1,2,3,4].publisher
let randomSu2 = [5,6,7,8].publisher

randomSu1
    .merge(with: randomSu2)
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

print("--------------------------")
print("CombineLatest")

let intValue = PassthroughSubject<Int, Never>()
let stringValue = PassthroughSubject<String, Never>()

intValue
    .combineLatest(stringValue)
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

intValue.send(0)
stringValue.send("AAAA")

stringValue.send("BB")

intValue.send(123123)

stringValue.send(completion: .finished)
intValue.send(completion: .finished)

print("--------------------------")
print("Zip")

let korea = PassthroughSubject<String, Never>()
let english = CurrentValueSubject<String, Never>("Hello")


korea
    .zip(english)
    .sink(receiveCompletion: { _ in
        print("완료")
    }, receiveValue: {
        print($0)
    })
    .store(in: &bag)

korea.send("안녕하세요")

korea.send("미안합니다")
english.send("Sorry")

english.send("MacBook")
english.send("iPhone")

korea.send("맥북")
korea.send("아이폰")

english.send(completion: .finished)
