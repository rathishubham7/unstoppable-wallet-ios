import RxSwift

class WalletStorage {
    private let appConfigProvider: IAppConfigProvider
    private let walletFactory: IWalletFactory
    private let storage: IEnabledWalletStorage

    init(appConfigProvider: IAppConfigProvider, walletFactory: IWalletFactory, storage: IEnabledWalletStorage) {
        self.appConfigProvider = appConfigProvider
        self.walletFactory = walletFactory
        self.storage = storage
    }

    private func enabledWallet(wallet: Wallet) -> EnabledWallet {
        EnabledWallet(
                coinId: wallet.coin.id,
                accountId: wallet.account.id
        )
    }

}

extension WalletStorage: IWalletStorage {

    func wallets(accounts: [Account]) -> [Wallet] {
        let coins = appConfigProvider.coins

        return storage.enabledWallets.compactMap { enabledWallet in
            guard let coin = coins.first(where: { $0.id == enabledWallet.coinId }) else {
                return nil
            }

            guard let account = accounts.first(where: { $0.id == enabledWallet.accountId }) else {
                return nil
            }

            return walletFactory.wallet(coin: coin, account: account)
        }
    }

    func save(wallets: [Wallet]) {
        let enabledWallets = wallets.map { enabledWallet(wallet: $0) }
        storage.save(enabledWallets: enabledWallets)
    }

    func delete(wallets: [Wallet]) {
        let enabledWallets = wallets.map { enabledWallet(wallet: $0) }
        storage.delete(enabledWallets: enabledWallets)
    }

    func clearWallets() {
        storage.clearEnabledWallets()
    }

}
