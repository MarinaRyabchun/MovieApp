//
//  CellWithContent.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import UIKit

protocol CellWithContentProtocol {
    func configure(_ viewModel: CellViewModel)
}

class CellWithContent: UITableViewCell, CellWithContentProtocol {
// MARK: - Properties
    public lazy var blockImage: UIImageView = {
        let blockImage = UIImageView()
        blockImage.contentMode = .scaleAspectFit
        blockImage.backgroundColor = .clear
        blockImage.translatesAutoresizingMaskIntoConstraints = false
        return blockImage
    }()
    public lazy var labelTitle: UILabel = {
        let title = UILabel()
        title.textColor = Constants.Colors.accent2
        title.font = Constants.Fonts.header2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    public lazy var imageStar: UIImageView = {
        let image = UIImage(named: "Star")
        let imageStar = UIImageView(image: image)
        imageStar.contentMode = .scaleAspectFill
        imageStar.translatesAutoresizingMaskIntoConstraints = false
        return imageStar
    }()
    public lazy var imDbRating: UILabel = {
        let description = UILabel()
        description.textColor = Constants.Colors.defaultColor
        description.font = Constants.Fonts.smallText
        description.numberOfLines = -1
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    public lazy var labelDescription: UILabel = {
        let description = UILabel()
        description.textColor = Constants.Colors.accent2
        description.font = Constants.Fonts.mainBody
        description.numberOfLines = -1
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    private lazy var tableViewCell: UITableViewCell = {
        let tableViewCell = UITableViewCell()
        tableViewCell.backgroundColor = Constants.Colors.black
        tableViewCell.addSubview(blockImage)
        tableViewCell.addSubview(labelTitle)
        tableViewCell.addSubview(labelDescription)
        tableViewCell.addSubview(imDbRating)
        return tableViewCell
    }()
// MARK: - Initial
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(blockImage)
        self.contentView.addSubview(labelTitle)
        self.contentView.addSubview(labelDescription)
        self.contentView.addSubview(imageStar)
        self.contentView.addSubview(imDbRating)

        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ viewModel: CellViewModel) {
        blockImage.downloaded(from: viewModel.image ?? "")
        labelTitle.text = viewModel.title
        imDbRating.text = "\(viewModel.imDbRating ?? "0")/10 IMDb"
        labelDescription.text = "\(viewModel.description ?? "") \(viewModel.genres ?? "")\n\(viewModel.runtimeStr ?? "")"
    }
// MARK: - setupConstraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blockImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            blockImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            blockImage.widthAnchor.constraint(equalToConstant: 100),
            blockImage.heightAnchor.constraint(equalToConstant: 140),
            
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            labelTitle.leadingAnchor.constraint(equalTo: blockImage.trailingAnchor, constant: 15),
            labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            imageStar.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15),
            imageStar.leadingAnchor.constraint(equalTo: blockImage.trailingAnchor, constant: 15),
            imageStar.widthAnchor.constraint(equalToConstant: 15),
            imageStar.heightAnchor.constraint(equalToConstant: 15),
            
            imDbRating.centerYAnchor.constraint(equalTo: imageStar.centerYAnchor),
            imDbRating.leadingAnchor.constraint(equalTo: imageStar.trailingAnchor, constant: 5),
            imDbRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            labelDescription.topAnchor.constraint(equalTo: imDbRating.bottomAnchor, constant: 15),
            labelDescription.leadingAnchor.constraint(equalTo: blockImage.trailingAnchor, constant: 15),
            labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}

