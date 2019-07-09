import UIKit
import UIExtensions
import SnapKit

class ManageAccountsViewController: WalletViewController {
    private let delegate: IManageAccountsViewDelegate

    private let tableView = UITableView(frame: .zero, style: .grouped)

    init(delegate: IManageAccountsViewDelegate) {
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "settings_manage_accounts.title".localized

        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.registerCell(forClass: ManageAccountCell.self)

        delegate.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return AppTheme.statusBarStyle
    }

    @objc func doneDidTap() {
        delegate.didTapDone()
    }

}

extension ManageAccountsViewController: IManageAccountsView {

    func showDoneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "button.done".localized, style: .plain, target: self, action: #selector(doneDidTap))
    }

    func reload() {
        tableView.reloadData()
    }

}

extension ManageAccountsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: ManageAccountCell.self), for: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ManageAccountCell else {
            return
        }

        cell.bind(viewItem: delegate.item(index: indexPath.row), onUnlink: { [weak self] in
            self?.delegate.didTapUnlink(index: indexPath.row)
        }, onBackup: { [weak self] in
            self?.delegate.didTapBackup(index: indexPath.row)
        })
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ManageAccountsTheme.rowHeight
    }

}
