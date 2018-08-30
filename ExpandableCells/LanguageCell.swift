//
//  ContactCell.swift
//  ExpandableCells
//
//  Created by Aleksander Kania on 17.04.2017.
//  Copyright © 2017 Aleksander Kania. All rights reserved.
//

import UIKit

final class LanguageCell: UITableViewCell {
    enum CellState {
        case collapsed
        case expanded
        
        var carretImage: UIImage {
            switch self {
                case .collapsed:
                    return #imageLiteral(resourceName: "expand")
                case .expanded:
                    return #imageLiteral(resourceName: "collapse")
            }
        }
    }
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
//    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var carret: UIImageView!
    @IBOutlet private weak var descriptionStackView: UIStackView!
    
    private let expandedViewIndex: Int = 1
    
    var state: CellState = .collapsed {
        didSet {
            toggle()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionStackView.arrangedSubviews.forEach {
            descriptionStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    override func awakeFromNib() {
        selectionStyle = .none
        containerView.layer.cornerRadius = 5.0
    }
    
    func update(name: String, description: String, logo: UIImage) {
        titleLabel.text = name

        (0...Int.random(in: 1...10)).forEach { _ in
            let label = UILabel()
            label.text = description
            descriptionStackView.addArrangedSubview(label)
        }
//        descriptionLabel.text = description
        icon.image = logo
    }
    
    private func toggle() {
        UIView.animate(withDuration: 0.3) {
            self.stackView.arrangedSubviews[self.expandedViewIndex].isHidden = self.stateIsCollapsed()
            self.stackView.arrangedSubviews[self.expandedViewIndex].alpha = self.stateIsCollapsed() ? 0 : 1
            self.stackView.layoutIfNeeded()

        }
        carret.image = state.carretImage
    }
    
    private func stateIsCollapsed() -> Bool {
        return state == .collapsed
    }
}
