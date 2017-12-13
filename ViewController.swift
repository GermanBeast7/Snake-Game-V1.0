//
//  ViewController.swift
//  Snake
//
//  Created by Matt T on 2017-11-23.
//  Copyright © 2017 Matthew Temniuk. All rights reserved.
//
//
import UIKit
import Foundation




class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var food: UIImageView!
    @IBOutlet weak var snakeHead: UIImageView!
    @IBOutlet weak var startPosition: UIImageView!
   
    @IBOutlet weak var foodStart: UIImageView!
    
 var timer:Timer?
    
    var snake = Snake(speed: 0.25)
    
   
 
    
    
    
    @objc func timerMethod(_ timer:Timer?) {
        snake.move(Image: snakeHead)
        let headHitBody = snake.headHitBody()
        if headHitBody == true {
            endGame()
            
        }
        let headHitWall = snake.headHitWall(Image: snakeHead)
        if headHitWall == true{
            endGame()
        }
        
        
        let head = snake.bodyCoordinates[0]
        if head.x == snake.foodCordinate.x && head.y == snake.foodCordinate.y {
            snake.genFood(Image: food,start: foodStart)
            let scoreNumber = snake.score + 100
            
            score.text = "\(scoreNumber)"
        }
    }
    
    func startGame() {
        if (timer != nil) {
            return
        }
        
        startButton!.isHidden = true
        snake.direction = Direction.up
        snake.length = 3
        snake.score = 0
        score.text = "0"
        snake.spawn()

            
        snake.genFood(Image: food,start: foodStart)
        timer = Timer.scheduledTimer(timeInterval: snake.speed, target: self, selector: #selector(timerMethod(_:)) , userInfo: nil, repeats: true)
        
    }
    
    func endGame() {
        startButton!.isHidden = false
        timer!.invalidate()
        timer = nil
        
        
        
    }

    @IBAction func upButton(_ sender: Any) {
        snake.changeDirection(Direction.up)
    }
    @IBAction func downButton(_ sender: Any) {
        snake.changeDirection(Direction.down)
    }
    @IBAction func rightButton(_ sender: Any) {
        snake.changeDirection(Direction.right)
    }
    @IBAction func leftButton(_ sender: Any) {
        snake.changeDirection(Direction.left)
    }
   
    @IBAction func startButton(_ sender: Any) {
        startGame()
        
        snakeHead.center.x = startPosition.center.x
       snakeHead.center.y = startPosition.center.y
    }
    
   
    
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

