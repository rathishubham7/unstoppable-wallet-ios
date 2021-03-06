import Foundation
import CurrencyKit

class TransactionViewItemFactory: ITransactionViewItemFactory {

    func viewItem(fromRecord record: TransactionRecord, wallet: Wallet, lastBlockInfo: LastBlockInfo? = nil, threshold: Int? = nil, rate: CurrencyValue? = nil) -> TransactionViewItem {
        TransactionViewItem(
                wallet: wallet,
                record: record,
                transactionHash: record.transactionHash,
                coinValue: CoinValue(coin: wallet.coin, value: record.amount),
                currencyValue: rate.map { CurrencyValue(currency: $0.currency, value: $0.value * record.amount) },
                type: record.type,
                date: record.date,
                status: record.status(lastBlockHeight: lastBlockInfo?.height, threshold: threshold),
                lockState: record.lockState(lastBlockTimestamp: lastBlockInfo?.timestamp),
                conflictingTxHash: record.conflictingHash
        )
    }

    func viewStatus(adapterStates: [Coin: AdapterState], transactionsCount: Int) -> TransactionViewStatus {
        let noTransactions = transactionsCount == 0
        var upToDate = true

        adapterStates.values.forEach {
            if case .syncing = $0 {
                upToDate = false
            }
        }

        return TransactionViewStatus(showProgress: !upToDate, showMessage: noTransactions)
    }

}
