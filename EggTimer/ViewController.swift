//
//  ViewController.swift
//  EggTimer
//
//  Created by Иван Станкин on 20.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTime = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var timer: Timer?
    
    var totalTime = 0
    
    var secondsPassed = 0
    
    var player: AVAudioPlayer!
    
    // MARK: UI Elements
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .systemRed
        progress.tintColor = .white
        progress.progress = 0
        
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop!", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(stopButtonPressed(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you want your eggs?"
        label.numberOfLines = 2
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var softButton: UIButton = {
        let button = UIButton()
        button.setTitle("Soft", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBackground, for: .normal)
        button.addTarget(self, action: #selector(hardnessTapped(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var mediumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Medium", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBackground, for: .normal)
        button.addTarget(self, action: #selector(hardnessTapped(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var hardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hard", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBackground, for: .normal)
        button.addTarget(self, action: #selector(hardnessTapped(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var image1: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "soft_egg")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var image2: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "medium_egg")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var image3: UIImageView = {
        let image = UIImageView()
        image.frame.size = CGSize(width: 287, height: 366)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "hard_egg")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var leftContainer: UIView = {
        let view = UIView()
        
        view.addSubview(image1)
        view.addSubview(softButton)
        
        NSLayoutConstraint.activate([
            softButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            softButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            softButton.heightAnchor.constraint(equalToConstant: 100),
            softButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            softButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            image1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image1.topAnchor.constraint(equalTo: view.topAnchor),
            image1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image1.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var middleContainer: UIView = {
        let view = UIView()
        
        view.addSubview(image2)
        view.addSubview(mediumButton)
        
        NSLayoutConstraint.activate([
            mediumButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mediumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mediumButton.heightAnchor.constraint(equalToConstant: 100),
            mediumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mediumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            image2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image2.topAnchor.constraint(equalTo: view.topAnchor),
            image2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightContainer: UIView = {
        let view = UIView()
        
        view.addSubview(image3)
        view.addSubview(hardButton)
        
        NSLayoutConstraint.activate([
            hardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hardButton.heightAnchor.constraint(equalToConstant: 100),
            hardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            image3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image3.topAnchor.constraint(equalTo: view.topAnchor),
            image3.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image3.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        
        stack.addArrangedSubview(leftContainer)
        stack.addArrangedSubview(middleContainer)
        stack.addArrangedSubview(rightContainer)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.heightAnchor.constraint(equalToConstant: 150),
            
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: stopButton.topAnchor, constant: -50),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    func setupViews() {
        view.addSubview(textLabel)
        view.addSubview(stack)
        view.addSubview(progressView)
        view.addSubview(stopButton)
    }
    
    // MARK: App logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setupViews()
        setupConstraints()
        
    }
    
    @objc func hardnessTapped(sender: UIButton) {
        
        timer?.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTime[hardness]!
        
        progressView.progress = 0.0
        
        secondsPassed = 0
        
        textLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerUpdate() {
        
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer?.invalidate()
            print("Does it stop?")
            textLabel.text = "Done!"
            alarmSound()
            stopButton.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.textLabel.text = "How do you want your eggs?"
            }
            
        }
        
        
    }
    
    @objc func stopButtonPressed(sender: UIButton) {
        
        timer?.invalidate()
        print("Timer stopped")
        textLabel.text = "How do you like your eggs?"
        progressView.progress = 0.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopButton.isHidden = true
        }
        
    }
    
    func alarmSound(){
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    
}

