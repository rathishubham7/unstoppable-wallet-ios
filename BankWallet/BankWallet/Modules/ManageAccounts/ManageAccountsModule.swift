protocol IManageAccountsView: class {
    func showDoneButton()
    func reload()
}

protocol IManageAccountsViewDelegate {
    func viewDidLoad()
    var itemsCount: Int { get }
    func item(index: Int) -> ManageAccountViewItem

    func didTapUnlink(index: Int)
    func didTapBackup(index: Int)
    func didTapShowKey(index: Int)
    func didTapCreate(index: Int)
    func didTapRestore(index: Int)

    func didTapDone()
}

protocol IManageAccountsInteractor {
    var predefinedAccountTypes: [IPredefinedAccountType] { get }
    func account(predefinedAccountType: IPredefinedAccountType) -> Account?
}

protocol IManageAccountsInteractorDelegate: class {
    func didUpdateAccounts()
}

protocol IManageAccountsRouter {
    func showUnlink(accountId: String)
    func showBackup(account: Account)
    func close()
}

struct ManageAccountItem {
    let predefinedAccountType: IPredefinedAccountType
    let account: Account?
}

struct ManageAccountViewItem {
    let title: String
    let coinCodes: String
    let state: ManageAccountViewItemState
}

enum ManageAccountViewItemState {
    case linked(backedUp: Bool)
    case notLinked(canCreate: Bool)
}
