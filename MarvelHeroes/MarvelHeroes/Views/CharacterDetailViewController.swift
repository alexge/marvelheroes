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
    
    private func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(comicsLabel)
        view.addSubview(comics)
        view.addSubview(storiesLabel)
        view.addSubview(stories)
        view.addSubview(eventsLabel)
        view.addSubview(events)
        view.addSubview(seriesLabel)
        view.addSubview(series)
        view.addSubview(backButton)
    }
    
    private func constrainSubviews() {
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        comicsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24).isActive = true
        comicsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        comics.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 24).isActive = true
        comics.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        comics.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        storiesLabel.topAnchor.constraint(equalTo: comics.bottomAnchor, constant: 24).isActive = true
        storiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        stories.topAnchor.constraint(equalTo: storiesLabel.bottomAnchor, constant: 24).isActive = true
        stories.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        stories.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        eventsLabel.topAnchor.constraint(equalTo: stories.bottomAnchor, constant: 24).isActive = true
        eventsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        events.topAnchor.constraint(equalTo: eventsLabel.bottomAnchor, constant: 24).isActive = true
        events.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        events.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        seriesLabel.topAnchor.constraint(equalTo: events.bottomAnchor, constant: 24).isActive = true
        seriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        series.topAnchor.constraint(equalTo: seriesLabel.bottomAnchor, constant: 24).isActive = true
        series.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        series.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
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
