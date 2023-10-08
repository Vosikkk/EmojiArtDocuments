//
//  DocumentInfoViewController.swift
//  EmojiArt
//
//  Created by Саша Восколович on 08.10.2023.
//

import UIKit

class DocumentInfoViewController: UIViewController {
    
    @IBOutlet weak var thumbnailAspectRatio: NSLayoutConstraint!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    var document: EmojiArtDocument? {
        didSet {
            updateUI()
        }
    }
    
    private let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        if sizeLabel != nil, createdDateLabel != nil, let url = document?.fileURL, let attributes = try? FileManager.default.attributesOfItem(atPath: url.path(percentEncoded: true)) {
            sizeLabel.text = "\(attributes[.size] ?? 0) bytes"
            if let created = attributes[.creationDate] as? Date {
                createdDateLabel.text = shortDateFormatter.string(from: created)
            }
        }
        if thumbnailImageView != nil, thumbnailAspectRatio != nil, let thumbnail = document?.thumbnail {
            thumbnailImageView.image = thumbnail
            thumbnailImageView.removeConstraint(thumbnailAspectRatio)
            let newthumbnailAspectRatio = NSLayoutConstraint(
                item: thumbnailImageView!,
                attribute: .width,
                relatedBy: .equal,
                toItem: thumbnailImageView,
                attribute: .height,
                multiplier: thumbnail.size.width / thumbnail.size.height,
                constant: 0)
            thumbnailAspectRatio = newthumbnailAspectRatio
            
            thumbnailImageView.addConstraint(thumbnailAspectRatio)
        }
    }
    
    
    @IBAction func done() {
        presentingViewController?.dismiss(animated: true)
    }
    
}
