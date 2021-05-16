//
//  HeaderView.swift
//  NewsApp
//
//  Created by Cengizhan DUMLU on 14.05.2021.
//

import UIKit

final class HeaderView : UIView {
    
    private var fontSize : CGFloat
    
    private lazy var headingLabel : UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "News"
        v.font = UIFont.boldSystemFont(ofSize: fontSize)
        return v
    }()
    
    private lazy var headerCircleImage : UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        v.image = UIImage(systemName: "largecircle.fill.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return v
    }()
    
    private lazy var plusImage : UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration.init(pointSize: fontSize, weight: .bold)
        v.image = UIImage(systemName: "plus", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return v
        
    }()
    
    private lazy var subheadlineLabel : UILabel = {
      let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = v.font.withSize(fontSize)
        v.text = "Top Headlines"
        v.textColor = .gray
        return v
    }()
    
    private lazy var headerStackView : UIStackView = {
        let v = UIStackView(arrangedSubviews: [headerCircleImage, headingLabel, plusImage])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        
        return v
    }()
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        addSubview(headerStackView)
        addSubview(subheadlineLabel)
        
        setupConstraints()
    }
    func setupConstraints(){
        //news header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        //subheadline
        NSLayoutConstraint.activate([
            subheadlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subheadlineLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subheadlineLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
    }
}
