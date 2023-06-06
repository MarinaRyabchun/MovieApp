//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol {
    var movie: CellViewModel? { get }
}

class DetailViewController: UIViewController, DetailViewControllerProtocol {
// MARK: - Properties
    var movie: CellViewModel?
    private lazy var scrollView: UIScrollView = {
      let sv = UIScrollView()
      sv.translatesAutoresizingMaskIntoConstraints = false
      return sv
    }()
    private lazy var contentView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    private lazy var blockImage: UIImageView = {
        let image = UIImage(named: "defaultImage")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.accent2
        label.font = Constants.Fonts.header1
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.defaultColor
        label.font = Constants.Fonts.smallText
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public lazy var imageStar: UIImageView = {
        let image = UIImage(named: "Star")
        let imageStar = UIImageView(image: image)
        imageStar.contentMode = .scaleAspectFill
        imageStar.translatesAutoresizingMaskIntoConstraints = false
        return imageStar
    }()
    private lazy var imDbRating: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.accent3
        label.font = Constants.Fonts.header2
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var imDbRatingVotes: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.defaultColor
        label.font = Constants.Fonts.smallText
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var cost: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.defaultColor
        label.font = Constants.Fonts.smallText
        label.numberOfLines = -1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var plotLabel: UILabel = {
        let label = UILabel()
        label.text = "Plot"
        label.textColor = Constants.Colors.accent2
        label.font = Constants.Fonts.header2
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var plot: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.accent2
        label.font = Constants.Fonts.mainBody
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
// MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            blockImage.downloaded(from: movie.image ?? "")
            labelTitle.text = movie.title
            labelDescription.text = "\(movie.description ?? "") \(movie.genres ?? "")\n\(movie.runtimeStr ?? "")"
            cost.text = "Cost: \(movie.stars ?? "Not Faund"))"
            imDbRating.text = "\(movie.imDbRating ?? "0")/10 IMDb"
            imDbRatingVotes.text = "\(movie.imDbRatingVotes ?? "0") votes"
            plot.text = movie.plot
        }
        view.backgroundColor = Constants.Colors.black
        setupSubViews()
        setupConstraints()
    }
// MARK: - View Methods
    private func setupSubViews() {
        contentView.addSubview(blockImage)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelDescription)
        contentView.addSubview(imageStar)
        contentView.addSubview(imDbRating)
        contentView.addSubview(imDbRatingVotes)
        contentView.addSubview(cost)
        contentView.addSubview(plot)
        contentView.addSubview(plotLabel)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    private func setupConstraints() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
          contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
          heightConstraint
        ])
        
        NSLayoutConstraint.activate([
            blockImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            blockImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            blockImage.widthAnchor.constraint(equalToConstant: 300),
            blockImage.heightAnchor.constraint(equalToConstant: 300),
            
            labelTitle.topAnchor.constraint(equalTo: blockImage.bottomAnchor, constant: 50),
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            cost.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 15),
            cost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            imDbRating.topAnchor.constraint(equalTo: cost.bottomAnchor, constant: 25),
            imDbRating.leadingAnchor.constraint(equalTo: imageStar.trailingAnchor, constant: 5),

            imageStar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -55),
            imageStar.centerYAnchor.constraint(equalTo: imDbRating.centerYAnchor),
            imageStar.widthAnchor.constraint(equalToConstant: 20),
            imageStar.heightAnchor.constraint(equalToConstant: 20),

            imDbRatingVotes.topAnchor.constraint(equalTo: imDbRating.bottomAnchor, constant: 10),
            imDbRatingVotes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imDbRatingVotes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            plotLabel.topAnchor.constraint(equalTo: imDbRatingVotes.bottomAnchor, constant: 30),
            plotLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            plotLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            plot.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: 15),
            plot.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            plot.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}

