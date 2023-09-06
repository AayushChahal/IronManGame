//
//  ViewController.swift
//  ironmangame
//
//  Created by Aayush Chahal on 22/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var Score : Int = 0
    var timer = Timer()
    var counter = 0
    var imarray = [UIImageView]()
    var hidetimer = Timer()
    var hscore : Int = 0
    
    //Views
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var im1: UIImageView!
    @IBOutlet weak var im2: UIImageView!
    @IBOutlet weak var im3: UIImageView!
    @IBOutlet weak var im4: UIImageView!
    @IBOutlet weak var im5: UIImageView!
    @IBOutlet weak var im6: UIImageView!
    @IBOutlet weak var im8: UIImageView!
    @IBOutlet weak var im9: UIImageView!
    @IBOutlet weak var im7: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score.text = "Score: \(Score)"
        
        let storedhighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedhighscore == nil{
            hscore = 0
            highscore.text = "Highscore: \(hscore)"
        }
        if let newscore = storedhighscore as? Int{
            hscore = newscore
            highscore.text = "Highscore: \(hscore)"
        }
        
        im1.isUserInteractionEnabled = true
        im2.isUserInteractionEnabled = true
        im3.isUserInteractionEnabled = true
        im4.isUserInteractionEnabled = true
        im5.isUserInteractionEnabled = true
        im6.isUserInteractionEnabled = true
        im7.isUserInteractionEnabled = true
        im8.isUserInteractionEnabled = true
        im9.isUserInteractionEnabled = true
        
        let recog1 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog2 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog3 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog4 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog5 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog6 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog7 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog8 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        let recog9 = UITapGestureRecognizer(target: self, action: #selector(scoreinc))
        
        im1.addGestureRecognizer(recog1)
        im2.addGestureRecognizer(recog2)
        im3.addGestureRecognizer(recog3)
        im4.addGestureRecognizer(recog4)
        im5.addGestureRecognizer(recog5)
        im6.addGestureRecognizer(recog6)
        im7.addGestureRecognizer(recog7)
        im8.addGestureRecognizer(recog8)
        im9.addGestureRecognizer(recog9)
        
        imarray = [im1, im2, im3, im4, im5, im6, im7, im8, im9]
        
        counter = 10
        time.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideim), userInfo: nil, repeats: true)
        hideim()
        
    }
    
    @objc func hideim(){
        for im in imarray {
            im.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(imarray.count - 1)))
        imarray[random].isHidden = false
    }
    
    @objc func scoreinc(){
        Score = Score + 1
        score.text = "Score: \(Score)"
    }
    
    @objc func countdown(){
        counter -= 1
        time.text = "Time: \(counter)"
        
        if counter == 0{
            timer.invalidate()
            hidetimer.invalidate()
            
            for im in imarray{
                im.isHidden = true
            }
            
            if Int(self.Score) >= Int(self.hscore) {
                self.hscore = self.Score
                highscore.text = "Highscore: \(self.hscore)"
                UserDefaults.standard.set(self.hscore, forKey: "highscore")
                
                
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Your Game is Over", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.Score = 0
                self.counter = 10
                self.score.text = "Score: \(self.Score)"
                self.time.text = "Time: \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                
                self.hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideim), userInfo: nil, repeats: true)
            }
            alert.addAction(okbutton)
            alert.addAction(replay)
            self.present(alert, animated: true)
            
        }
    }


}

