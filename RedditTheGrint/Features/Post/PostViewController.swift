//
//  PostViewController.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 17/5/23.
//

import UIKit
import WebKit

class PostViewController: UIViewController {

    var stringURL: String!
    private var webView: WKWebView!
    private var refreshControl: UIRefreshControl?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: stringURL)!
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        refreshControl = UIRefreshControl()
        refreshControl?.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.addSubview(refreshControl!)
        refreshControl?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        refreshControl?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        refreshControl?.beginRefreshing()
    }

}

extension PostViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        refreshControl?.endRefreshing()
        refreshControl?.removeFromSuperview()
        refreshControl = nil
    }

}
