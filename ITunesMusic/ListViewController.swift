//
//  ListViewController.swift
//  
//
//  Created by 高橋智貴 on 2015/10/28.
//
//

import UIKit

class ListViewController: UITableViewController {
    
    private var results: [NSDictionary]?

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListCell
        if let result = results?[indexPath.row] {
            if let artworkUrl = result["artworkUrl100"] as? String {
                cell.artworkImageView.setImageWithURL(NSURL(string: artworkUrl)!)
            } else {
                cell.artworkImageView.image = nil
            }
            cell.trackLabel.text = result["trackName"] as? String
            cell.artistLabel.text = result["artistName"] as? String
        }
        return cell
    }
    
    

   
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow, result = results?[indexPath.row] {
                vc.trackName = result["trackName"] as! String
                vc.previewUrl = result["previewUrl"] as? String
            }
        }
    }
    

}

extension ListViewController: UISearchBarDelegate {
    
    // searchBarのSearchボタンをタップしたときの処理
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // キーボードを閉じる
        
        // url encode　例. スピッツ > %83X%83s%83b%83c
        let text = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        if let text = text {
            AFHTTPSessionManager().GET(
                "https://itunes.apple.com/search?term=\(text)&country=JP&lang=ja_jp&media=music",
                parameters: nil,
                success: { (task: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                    if let data = response as? NSDictionary, results = data["results"] as? [NSDictionary] {
                        self.results = results
                        self.tableView.reloadData() // 再描画
                    }
                },
                failure: nil)
        }
    }
}

class ListCell: UITableViewCell {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
}
