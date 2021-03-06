import UIKit
class TableView : UITableViewController
{
    var colleges : [College] = []
    var t1 : UITextField!
    var t2 : UITextField!
    var t3 : UITextField!
    var tableCell : TableCell!
    override func viewDidLoad()
    {
        colleges.append(College(n: "University of Illinois", nos: 44087, l: "Champaign, IL"))
        colleges[0].image = UIImage(contentsOfFile: "/Users/student/Desktop/Mobile Apps/apps/CollegeProfile/CollegeProfile/Assets.xcassets/illinoisImage.imageset/Image.png")
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return colleges.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableCell
        let name = colleges[indexPath.row].name
        cell.collegeName.text = name
        cell.detailTextLabel?.text = colleges[indexPath.row].location
        return cell
    }
    
    
    @IBAction func addCollege(sender: AnyObject)
    {
        let alert = UIAlertController(title: "Add College", message: nil , preferredStyle: .Alert)
        let action = UIAlertAction(title: "Done", style: .Default, handler: {(alert: UIAlertAction!) in self.newCell()})
        let action2 = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alert.addTextFieldWithConfigurationHandler
            {
                (textField: UITextField) -> Void in textField.placeholder = "(College Name)"
                self.t1 = textField
            }
        alert.addTextFieldWithConfigurationHandler
            {
                (textField: UITextField) -> Void in textField.placeholder = "(Number of students)"
                self.t2 = textField
            }
        alert.addTextFieldWithConfigurationHandler
            {
                (textField: UITextField) -> Void in textField.placeholder = "(Location)"
                self.t3 = textField
            }
        alert.addAction(action)
        alert.addAction(action2)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let moving = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(moving, atIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! TableCell!
        tableCell = currentCell

        performSegueWithIdentifier("description", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            colleges.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func editing(sender: AnyObject)
    {
        self.editing = !self.editing
    }
    
    func newCell()
    {
        colleges.append(College(n: t1.text!, nos: (Int)(t2.text!)!, l: t3.text!))
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "description")
        {
            if let destinationVC = segue.destinationViewController as? Description
            {
                for var i = 0; i < colleges.count; i++
                {
                    if tableCell.collegeName.text! == colleges[i].name
                    {
                        destinationVC.n = colleges[i].name
                        destinationVC.l = colleges[i].location
                        destinationVC.e = colleges[i].numberOfStudents
                        destinationVC.url = colleges[i].collegeURL
                       
                            destinationVC.i = colleges[i].image
                        
                    }
                }
                destinationVC.colleges = self.colleges
                
            }
            
        }
    }
    
    
}