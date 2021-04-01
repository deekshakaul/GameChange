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
        label.text = "someText"
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "someText"
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        labelStackView.spacing = 10
        
        contentView.addSubview(labelStackView)
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    public func configureCell(cellObject: TwoLabelCellObject) {
        firstLabel.text = cellObject.firstText
        secondLabel.text = cellObject.secondText
    }
    

}
