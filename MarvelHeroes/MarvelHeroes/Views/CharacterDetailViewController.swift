//
//  CharacterDetailViewController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var character: Character
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        sv.isUserInteractionEnabled = true
        return sv
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var comicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Most Recent Comics"
        return label
    }()
    
    var comics: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    var storiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Most Recent Stories"
        return label
    }()
    
    var stories: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    var eventsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Most Recent Events"
        return label
    }()
    
    var events: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    var seriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Most Recent Series"
        return label
    }()
    
    var series: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
        
        title = character.name
        view.backgroundColor = .white
        
        addSubviews()
        constrainSubviews()
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = view.bounds.size
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(comicsLabel)
        containerView.addSubview(comics)
        containerView.addSubview(storiesLabel)
        containerView.addSubview(stories)
        containerView.addSubview(eventsLabel)
        containerView.addSubview(events)
        containerView.addSubview(seriesLabel)
        containerView.addSubview(series)
        containerView.addSubview(backButton)
    }
    
    private func constrainSubviews() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        comicsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24).isActive = true
        comicsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        comics.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 24).isActive = true
        comics.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        comics.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        storiesLabel.topAnchor.constraint(equalTo: comics.bottomAnchor, constant: 24).isActive = true
        storiesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        stories.topAnchor.constraint(equalTo: storiesLabel.bottomAnchor, constant: 24).isActive = true
        stories.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        stories.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        eventsLabel.topAnchor.constraint(equalTo: stories.bottomAnchor, constant: 24).isActive = true
        eventsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        events.topAnchor.constraint(equalTo: eventsLabel.bottomAnchor, constant: 24).isActive = true
        events.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        events.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        seriesLabel.topAnchor.constraint(equalTo: events.bottomAnchor, constant: 24).isActive = true
        seriesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        series.topAnchor.constraint(equalTo: seriesLabel.bottomAnchor, constant: 24).isActive = true
        series.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        series.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        backButton.topAnchor.constraint(equalTo: series.bottomAnchor, constant: 48).isActive = true
        backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        backButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    private func configureSubviews() {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
        
        var comicCount = 0
        for comic in character.comics {
            let label = UILabel()
            label.text = comic.name
            comics.addArrangedSubview(label)
            comicCount += 1
            if comicCount == 3 {
                break
            }
        }
        
        var storyCount = 0
        for story in character.stories {
            let label = UILabel()
            label.text = story.name
            stories.addArrangedSubview(label)
            storyCount += 1
            if storyCount == 3 {
                break
            }
        }
        
        var eventCount = 0
        for event in character.events {
            let label = UILabel()
            label.text = event.name
            events.addArrangedSubview(label)
            eventCount += 1
            if eventCount == 3 {
                break
            }
        }
        
        var seriesCount = 0
        for seriesItem in character.series {
            let label = UILabel()
            label.text = seriesItem.name
            series.addArrangedSubview(label)
            seriesCount += 1
            if seriesCount == 3 {
                break
            }
        }
        
        backButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
}
