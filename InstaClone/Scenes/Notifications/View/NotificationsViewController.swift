//
//  NotificationsViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class NotificationViewController: UITableViewController {
    var viewModel: NotificationViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        getNotifications()
    }

    private func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"

    }

    private func configureTableView() {
        tableView.register(NotificationsTableViewCell.self, forCellReuseIdentifier: NotificationsTableViewCell.identifier)

        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

    private func getNotifications() {
        self.viewModel?.getNotifications {
            self.tableView.reloadData()
        }
    }
}

extension NotificationViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.notifications.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as! NotificationsTableViewCell

        cell.delegate = self

        if let notification = self.viewModel?.notifications[indexPath.row] {
            cell.viewModel = NotificationsTableViewCellViewModel(notification: notification)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotificationViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        guard let uid = viewModel?.notifications[indexPath.row].uid else { return }

        viewModel?.getUser(with: uid)
    }
}

// MARK: - NotificationCellDelegate

extension NotificationViewController: NotificationCellDelegate {

    func cell(_ cell: NotificationsTableViewCell, wantsToFollow uid: String) {
        self.viewModel?.follow(with: uid, completion: { _ in
            cell.viewModel?.notification.userIsFollowed.toggle()

            DispatchQueue.main.async {
                cell.setupFollowButtonState()
            }
        })
    }

    func cell(_ cell: NotificationsTableViewCell, wantsToUnFollow uid: String) {
        self.viewModel?.unFollow(with: uid, completion: { _ in
            cell.viewModel?.notification.userIsFollowed.toggle()

            DispatchQueue.main.async {
                cell.setupFollowButtonState()
            }
        })
    }

    func cell(_ cell: NotificationsTableViewCell, wantsToViewPost uid: String) {
        viewModel?.getPost(with: uid)
    }
}
