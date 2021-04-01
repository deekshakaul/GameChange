//
//  CustomtableViewCell.swift
//  TableView
//
//  Created by Deeksha Kaul on 03/10/18.
//  Copyright © 2018 Deeksha Kaul. All rights reserved.
//

import UIKit

class TwoLabelTableViewCell: UITableViewCell {
        
    var firstLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.font = UIFont(name: FontFamily.bold, size: FontSize.header)
        return label
    }()
    
    var secondLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.font = UIFont(name: FontFamily.standard, size: FontSize.body)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }

    fileprivate func setUpUI() {

        let labelStackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
        labelStackView.axis = .vertical
        labelStackView.alignment = .top
        labelStackView.distribution = .fill
        labelStackView.spacing = LayoutConstants.padding1x
        
        contentView.addSubview(labelStackView)
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.padding1nHalfx).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.padding1nHalfx).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.padding1x).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.padding1x).isActive = true
    }
    
    public func configureCell(cellObject: TwoLabelCellObject) {
        firstLabel.text = cellObject.firstText
        secondLabel.text = cellObject.secondText?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if let hide = cellObject.secondText?.isEmpty, hide {
            secondLabel.isHidden = true
        } else {
            secondLabel.isHidden = false
        }
    }
}
