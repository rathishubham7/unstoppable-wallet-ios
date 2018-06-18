import Foundation

class Factory {
    static let instance = Factory()

    private var instances = [String: Any]()

    private init() {
    }

    var stubWalletDataProvider: StubWalletDataProvider { return getInstance(creator: {
        return StubWalletDataProvider()
    })}

    var stubSettingsProvider: StubSettingsProvider { return getInstance(creator: {
        return StubSettingsProvider()
    })}

    var stubUnspentOutputProvider: StubUnspentOutputProvider { return getInstance(creator: {
        return StubUnspentOutputProvider()
    })}

    var stubExchangeRateProvider: StubExchangeRateProvider { return getInstance(creator: {
        return StubExchangeRateProvider()
    })}

    var userDefaultsStorage: UserDefaultsStorage { return getInstance(creator: {
        return UserDefaultsStorage()
    })}

    var randomProvider: RandomProvider { return getInstance(creator: {
        return RandomProvider()
    })}

    var mnemonicManager: MnemonicManager { return getInstance(creator: {
        return MnemonicManager()
    })}

    private func getInstance<T>(creator: () -> T) -> T {
        let className = String(describing: T.self)

        if let instance = instances[className] as? T {
            return instance
        }

        let instance = creator()
        instances[className] = instance
        return instance
    }

}
