import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblMovieInformation: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var tblMovieInformation: UITableView!
    @IBOutlet weak var btnMoviePicker: UIButton!
    
    var moviesData : NSArray?
    var selectedMovieIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial setup
        selectedMovieIndex = 0
        loadMoviesData()
        
        // Set the flag image to the imageview.
        imgFlag.image = UIImage(named: "flag")
        
        // Make self the delegate and datasource of the tableview.
        tblMovieInformation.delegate = self;
        tblMovieInformation.dataSource = self;
    }

    // MARK: Methods
    @IBAction func showMoviesList(sender: AnyObject) {
        let moviePicker = UIAlertController(title: "Movies List", message: "Pick a movie", preferredStyle: .ActionSheet)
        
        for var i=0; i<moviesData?.count; i += 1{
            let movieDataDictionary : NSDictionary = moviesData?.objectAtIndex(i) as! NSDictionary
            let currentMovieIndex = i
            let movieTitle = movieDataDictionary.objectForKey("Movie Title") as! String
            
            let normalAction = UIAlertAction(title: movieTitle, style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                
                self.selectedMovieIndex = currentMovieIndex;
                self.tblMovieInformation.reloadData()
            })
            
            moviePicker.addAction(normalAction)
        }
        
        let closeAction = UIAlertAction(title: NSLocalizedString("Close", comment: "The Close button title"), style: UIAlertActionStyle.Cancel) { (action: UIAlertAction!) -> Void in
            
            
        }
        
        moviePicker.addAction(closeAction)
        
        self.presentViewController(moviePicker, animated: true, completion: nil)
    }
    
    func loadMoviesData(){
        let moviesDataPath =  NSBundle.mainBundle().pathForResource("MoviesData", ofType: "plist")
        moviesData = NSArray(contentsOfFile: moviesDataPath!)
    }
    
    func getFormattedStringFromNumber(number: Double) -> String{
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        return numberFormatter.stringFromNumber(number)!
    }
    
    func getFormattedStringFromDate(aDate: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        return dateFormatter.stringFromDate(aDate)
    }
    
    // MARK: UITableView delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 7 {
            let movieDataDictionary : NSDictionary = moviesData?.objectAtIndex(selectedMovieIndex!) as! NSDictionary
            
            let link = movieDataDictionary.objectForKey("Link") as! String
            
            UIApplication.sharedApplication().openURL(NSURL(string: link)!)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        let movieDataDictionary : NSDictionary = moviesData?.objectAtIndex(selectedMovieIndex!) as! NSDictionary

        switch indexPath.row{
            
            case 0:
                // Dequeue the proper cell.
                cell = tableView.dequeueReusableCellWithIdentifier("idCellTitle", forIndexPath: indexPath) as UITableViewCell
            
                // Set the cell's title label text.
                cell.textLabel!.text = movieDataDictionary.objectForKey("Movie Title") as? String
            
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("idCellCategory", forIndexPath: indexPath) as UITableViewCell
            
                let categoriesArray = movieDataDictionary.objectForKey("Category") as! [String]
                var allCategories = String()
                for aCategory in categoriesArray{
                    allCategories += NSLocalizedString(aCategory, comment: "The category of the movie") + " "
                }
            
                cell.textLabel!.text = allCategories
        
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("idCellRating", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel!.text = getFormattedStringFromNumber(movieDataDictionary.valueForKey("Rating") as! Double) + " / 10"
            
            case 3:
                cell = tableView.dequeueReusableCellWithIdentifier("idCellReleaseDate", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel!.text = getFormattedStringFromDate(movieDataDictionary.objectForKey("Release Date") as! NSDate)

            case 4:
                cell = tableView.dequeueReusableCellWithIdentifier("idCellDuration", forIndexPath: indexPath) as UITableViewCell
                
                let duration = movieDataDictionary.objectForKey("Duration") as! Int
                cell.textLabel!.text = String(duration) + " " + NSLocalizedString("minutes", comment: "The minutes literal for the movie duration")
            
            case 5:
                cell = tableView.dequeueReusableCellWithIdentifier("idCellDirector", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel!.text = movieDataDictionary.objectForKey("Director") as? String
            
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("idCellLink", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel!.text = movieDataDictionary.objectForKey("Link") as? String
        }
        
        return cell!
    }
}

