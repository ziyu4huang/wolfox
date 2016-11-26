//: Playground - noun: a place where people can play
//: xcode 8 playground uiview

//: [Previous](@previous)


import UIKit
import PlaygroundSupport
//import HelloLib


public class ViewController: UIViewController {

    //@IBOutlet weak var containerView: UIView!

    public var containerView: UIView!
    var circle: UIView!
    var rectangle: UIView!
    var become = false

    func setupUi() {
        containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 350.0, height: 600.0))



        circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
        circle.center = containerView.center
        circle.layer.cornerRadius = 25.0

        let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
        circle.backgroundColor = startingColor

        containerView.addSubview(circle);

        rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        rectangle.center = containerView.center
        rectangle.layer.cornerRadius = 5.0

        rectangle.backgroundColor = UIColor.white

        containerView.addSubview(rectangle)

        // Add tap gesture recognizer to view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        containerView.addGestureRecognizer(tapGesture)
        become = false


    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUi()

    }

    func doAnim() {
        if become {
            print(" go back init")


            UIView.animate(withDuration: 1.0, animations: { () -> Void in

                let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)

                self.circle.backgroundColor = startingColor

                let scaleTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                self.circle.transform = scaleTransform

                let rotationTransform = CGAffineTransform(rotationAngle: 0)

                self.rectangle.transform = rotationTransform
                self.become = false
            })

        } else {
            print("become it")


            UIView.animate(withDuration: 2.0, animations: { () -> Void in

                let endingColor = UIColor(red: (255.0/255.0), green: (61.0/255.0), blue: (24.0/255.0), alpha: 1.0)
                self.circle.backgroundColor = endingColor



                let scaleTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)

                self.circle.transform = scaleTransform

                let rotationTransform = CGAffineTransform(rotationAngle: 3.14)
                
                self.rectangle.transform = rotationTransform
                self.become = true
            })
        }
        
    }
    
    // this method is called when a tap is recognized
    func handleTap(sender: UITapGestureRecognizer) {
        
        print("tap \(become)")
        doAnim()
    }
}



let controll = ViewController()

print(controll)

controll.viewDidLoad()



PlaygroundPage.current.liveView = controll.containerView


//: [Next](@next)
