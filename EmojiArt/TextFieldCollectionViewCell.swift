//
//  TextFieldCollectionViewCell.swift
//  EmojiArt
//
//  Created by Саша Восколович on 26.09.2023.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var resingationHandler: (() -> Void)?
}




extension TextFieldCollectionViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resingationHandler?()
    }
}
