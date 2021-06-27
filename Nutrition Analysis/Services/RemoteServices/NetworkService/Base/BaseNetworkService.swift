//
//  BaseNetworkService.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Moya
import RxSwift

enum NetworkServiceType {
    case live
    case test
}

class BaseNetworkService<T: TargetType> {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<T>!
    
    // MARK: - Init
    init(type: NetworkServiceType = .live) {
        let serviceType = type == .live ? MoyaProvider<T>.neverStub : MoyaProvider<T>.immediatelyStub
        provider = MoyaProvider<T>(stubClosure: serviceType, plugins: [])
    }
    
    func request<R: Codable>(target: T) -> Observable<Result<R, Error>> {
        return self.provider.rx.request(target)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .asObservable()
            .flatMap({ response -> Observable<Result<R, Error>> in
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(R.self, from: response.data)
                    return Observable<Result<R, Error>>.just(.success(data))
                } catch let error {
                    return Observable<Result<R, Error>>.just(.failure(error))
                }
            })
            .catchError({ error -> Observable<Result<R, Error>> in
                return Observable<Result<R, Error>>.just(.failure(error))
            }).observeOn(ConcurrentMainScheduler.instance)
    }
}
