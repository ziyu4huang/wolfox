//: [Previous](@previous)
//: Demo basic table view construct flow
//: Demo how plull to refresh works in table view
//:     use the new dispatch function to accomplish simulate reload data

import UIKit
import PlaygroundSupport

var str = "Hello, playground"


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Data model: These strings will be the data for the table view cells
    //var animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    var animals: [String] = []

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()


        self.tableView = UITableView()

        //refer to http://stackoverflow.com/questions/24475792/how-to-use-pull-to-refresh-in-swift-2
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    func refresh(sender:AnyObject) {
        //http://swiftable.io/2016/06/dispatch-queues-swift-3/

        refreshControl?.attributedTitle = NSAttributedString(string: "Now refresing")

        DispatchQueue.global(qos: .background).async {
            print("refresh called")
            sleep(3)
            print("refresh end")
            self.animals.append("xxx")
            DispatchQueue.main.sync {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")


            }
        }

    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!

        // set the text from the data model
        cell.textLabel?.text = self.animals[indexPath.row]

        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("You tapped cell number \(indexPath.).")
        print("tap on: \(animals[indexPath.row])")
    }


    func numberOfSections(in: UITableView) -> Int {

        var numOfSection = animals.count

        if numOfSection > 0 {
            //print("has data ")
            self.tableView.backgroundView = nil
            numOfSection = 1

        } else {
            //print("no data set background text")
            var noDataLabel: UILabel = UILabel(frame: CGRect(x: 0.0, y:0, width: self.tableView.bounds.size.width , height: self.tableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            self.tableView.backgroundView = noDataLabel
            
        }
        return numOfSection
    }


}

let con = ViewController()
con.viewDidLoad()

let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 600.0))
con.tableView.frame = CGRect(x: 0.0, y: 35.0, width: 280.0, height: 500.0)
view.addSubview( con.tableView)

let btn = UIButton(frame: CGRect(x:0.0, y: 0.0, width:300.0, height: 30.0))
btn.backgroundColor = UIColor.blue
view.addSubview(btn)
btn.setTitle("test", for: .normal)

PlaygroundPage.current.liveView = view




//: [Next](@next)
