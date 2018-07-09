import Foundation
import WalletKit

class MnemonicManager: IMnemonic {

    func generateWords() -> [String] {
        return (try? Mnemonic.generate()) ?? []
    }

    func validate(words: [String]) -> Bool {
        let set = Set(words)

        guard set.count == 12 else {
            return false
        }

        let wordsList = WordList.english.map(String.init)

        for word in set {
            if word == "" || !wordsList.contains(word) {
                return false
            }
        }

        return true
    }

}