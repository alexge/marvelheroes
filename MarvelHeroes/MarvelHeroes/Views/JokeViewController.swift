//
//  JokeViewController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

protocol JokeViewControllerDelegate: class {
    func didFinishAnimations()
}

class JokeViewController: UIViewController {
    
    var jokeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Just kidding..."
        label.alpha = 0
        return label
    }()
    
    var marvelLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Marvel")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = .clear
        logo.alpha = 0
        return logo
    }()
    
    weak var delegate: JokeViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .black
        
        view.addSubview(jokeLabel)
        view.addSubview(marvelLogo)
        
        jokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        marvelLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        marvelLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        marvelLogo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        marvelLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateKeyframes(withDuration: 4, delay: 0.25, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.125) {
                self.jokeLabel.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.125) {
                self.jokeLabel.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.125) {
                self.marvelLogo.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.875, relativeDuration: 0.125) {
                self.marvelLogo.alpha = 1
            }
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.didFinishAnimations()
            }
        }
    }
}
