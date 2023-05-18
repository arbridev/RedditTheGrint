//
//  PostsViewController.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 16/5/23.
//

import UIKit

class PostsViewController: UITableViewController {

    // MARK: Properties

    private var viewModel = ViewModel()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)

        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableView.automaticDimension

        setRefreshControl()
        viewModel.update = { [weak self] vm in
            self?.updateUI()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.restoreState() {
            updateUI()
        } else {
            viewModel.fetchPosts()
        }
    }

    // MARK: Behavior

    @objc func refreshing() {
        tableView.refreshControl = nil
        setRefreshControl()
        viewModel.fetchPosts()
    }

    @objc func orientationChanged() {
        updateUI()
    }

    private func updateUI() {
        tableView.reloadData()
    }

    private func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewModel.posts[indexPath.row]

        if UIDevice.current.orientation == .portrait ||
            UIDevice.current.orientation == .portraitUpsideDown ||
            UIDevice.current.orientation == .unknown
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostViewCell.self)", for: indexPath) as! PostViewCell
            cell.config(post)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostLandscapeViewCell.self)", for: indexPath) as! PostLandscapeViewCell
            cell.config(post)
            return cell
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.row]
        let vc = PostViewController()
        vc.stringURL = post.data.url
        self.present(vc, animated: true)
    }

}
