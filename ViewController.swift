//
//  ViewController.swift
//  Snake
//
//  Created by Matt T on 2017-11-23.
//  Copyright © 2017 Matthew Temniuk. All rights reserved.
//

import UIKit

struct Coordinates{
    var x: UInt32
    var y: UInt32
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    enum Direction{
        case up,down,left,right
    }
    
    class Snake{
        
        var isAlive:Bool = true
        var length:UInt = 3
        var oldBodyCoords: Coordinates
        var direction: Direction
        var speed:Int
        var bodyCoordinates: [Coordinates]
        var foodCordinate: Coordinates
        
        
        init(speed:Int) {
            
            direction = Direction.up
            self.speed = speed
            foodCordinate = Coordinates(x: 0, y: 0)
            bodyCoordinates = [Coordinates(x: 0, y: 0)]
            oldBodyCoords = Coordinates(x: 0, y: 0)
        }
        
        func move(body: inout [Coordinates])-> [Coordinates]{   //needs to remove end and shift all the other body parts accordingly
            var headPoint = bodyCoordinates[0]
            if direction==Direction.up{
                if headPoint.y != 20{
                    headPoint.y+=1
                }
            }else if direction==Direction.down{
                if headPoint.y != 1 {
                    headPoint.y-=1
                    
                }
                
            }else if direction==Direction.right{
                if headPoint.x != 20{
                    headPoint.x+=1
                    
                }
                
            }else {
                if headPoint.x != 1{
                    headPoint.x-=1
                    
                }
                bodyCoordinates.insert(headPoint, at: 0)
                oldBodyCoords = bodyCoordinates.removeLast()
                
            }
            return body
        }
        
        func spawn(){
            bodyCoordinates[0].x = arc4random_uniform(20) + 1
            bodyCoordinates[0].y = arc4random_uniform(20) + 1
            bodyCoordinates[1].x = bodyCoordinates[0].x
            bodyCoordinates[1].y = bodyCoordinates[0].y-1
            bodyCoordinates[2].x = bodyCoordinates[1].x
            bodyCoordinates[2].y = bodyCoordinates[1].y-1
            
        }
        func foodAte(){
            length+=1
            genFood()
            bodyCoordinates.insert(oldBodyCoords, at: bodyCoordinates.endIndex)
        }
        func genFood(){
            var x: UInt32 = 0
            var y: UInt32 = 0
            
            var canGen: Bool = false
            
            while canGen != true   {
                x = arc4random_uniform(20) + 1
                y = arc4random_uniform(20) + 1
                for index in bodyCoordinates[0..<bodyCoordinates.count]    {
                    if x != index.x  &&  y != index.y {
                        canGen = true
                        foodCordinate.x = x
                        foodCordinate.y = y
                    } else{
                        
                        canGen = false
                        
                    }
                }
                
                
            }
            
        }
        
        func changeDirection(_ newDirection: Direction)  {
            if (direction == Direction.down || direction == Direction.up) && (newDirection == Direction.down || newDirection == Direction.up){
                
        
            }
            else if (direction == Direction.left || direction == Direction.right) && (newDirection == Direction.left || newDirection == Direction.right){
                
            }
            else{
                direction = newDirection
            }
            
        }
        
        func headHitBody() -> Bool{
            let headPoint = bodyCoordinates[0]
            for bodyPoint in bodyCoordinates[1..<bodyCoordinates.count]   {
                if bodyPoint.x == headPoint.x && bodyPoint.y == headPoint.y {
                    return true
                }
            }
            return false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

