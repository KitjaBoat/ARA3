//
//  JobDetailViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit
import MapKit

class JobDetailViewController: UIViewController {
    
    @IBOutlet weak var secondSection: UITableView!
    
    var job:JobDetail?
    var jobModel = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        firstSection.delegate = self
//        firstSection.dataSource = self
//        firstSection.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
        
        secondSection.delegate = self
        secondSection.dataSource = self
        secondSection.allowsSelection = true
        secondSection.register(UINib(nibName: "CustomeCell", bundle: nil), forCellReuseIdentifier: "CustomeCell")
       
        
        setupTableView()

    }
    
    func setupTableView() {
        guard let job = job else {
            return
        }
        
        jobModel.append(Section(title: job.jobTitle, value: [
            JobToSetupTableView(title: "\(job.jobStatusID)", icon: nil),
            JobToSetupTableView(title: "\(job.timeline.opened)", icon: UIImage(named: "ic_work_open")),
            JobToSetupTableView(title: "\(job.timeline.assignment)", icon: UIImage(named: "ic_work_receive")),
            JobToSetupTableView(title: "\(job.timeline.condition.slaResponse)", icon: UIImage(named: "ic_work_expect")),
            JobToSetupTableView(title: "\(job.timeline.condition.slaFixed)", icon: UIImage(named: "ic_work_sla_fixed")),
            JobToSetupTableView(title: job.problem, icon: UIImage(named: "ic_work_problem")),
            JobToSetupTableView(title: job.dispatcherRecommend, icon: UIImage(named: "ic_chat")),
            JobToSetupTableView(title: job.customer.location.address, icon: UIImage(named: "ic_work_location")),
            JobToSetupTableView(title: job.contactRemark, icon: UIImage(named: "ic_work_remark"))
        ]))
        
        
        jobModel.append(Section(title: Title.ATTACHMENT.rawValue, value: [
                        JobToSetupTableView(title: Title.ATTACHMENT.rawValue, icon: nil)
                        ]))

        jobModel.append(Section(title: Title.WARRANTY.rawValue, value: [
            JobToSetupTableView(title: Title.WARRANTY_Owner.rawValue, icon: nil),
            JobToSetupTableView(title: Title.WARRANTY_Supplier.rawValue, icon: nil)
        ]))
        
        jobModel.append(Section(title: Title.GENERAL.rawValue, value:[
            JobToSetupTableView(title: Title.GENERAL_Sn.rawValue, icon: UIImage(named: "ic_work_serial")),
            JobToSetupTableView(title: Title.GENERAL_Phone.rawValue, icon: UIImage(named: "ic_work_phone"))
        ]))
        
        jobModel.append(Section(title: Title.PART.rawValue, value: [
            JobToSetupTableView(title: Title.PART_Mp.rawValue, icon: nil),
            JobToSetupTableView(title: Title.PART_Mb.rawValue, icon: nil)
        ]))
        
        jobModel.append(Section(title: Title.ENGINEER.rawValue, value: [
            JobToSetupTableView(title: Title.ENGINEER_Accept.rawValue, icon: nil),
            JobToSetupTableView(title: Title.ENGINEER_Accept_Button.rawValue, icon: nil)
            ]))
        
        secondSection.reloadData()
    }

}

extension JobDetailViewController:UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobModel[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == firstSection {
//            if let job = job {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "NewJobTableViewCell", for: indexPath) as! NewJobTableViewCell
//                cell.titleFirstLabel.text = job.jobTitle
//                cell.titleSecondLabel.text = job.problem
//                cell.subTitleFristIcon.image = UIImage(named: "ic_work_location")
//                cell.subTitleFristLabel.text = job.customer.location.address
//                cell.subTitleSecondLeftIcon.image = UIImage(named: "ic_work_receive")
//                cell.subTitleSecondLeftLabel.text = "\(job.timeline.assignment)"
//                cell.subTitleSecondRightIcon.image = UIImage(named: "ic_work_expect")
//                cell.subTitleSecondRightLabel.text = "\(job.timeline.condition.slaResponse)"
//                cell.subTitleThirdIcon.image = UIImage(named: "ic_work_appoint")
//                return cell
//            }
//        }
        //        else if tableView == secondSection {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomeCell", for: indexPath) as! CustomeCell
        let model = jobModel[indexPath.section].value[indexPath.row]
        cell.rightIcon.isHidden = true
        cell.rightIconmainLabel.isHidden = true
        cell.mainLabel.text = model.title
        cell.icon.image = model.icon
        cell.click.isHidden = true
        cell.headLabel.isHidden = true
        cell.engButton.isHidden = true
        
        
        if let job = job {
            switch model.icon {
            case UIImage(named: "ic_work_open"):
                cell.headLabel.text = "Open Date"
                cell.headLabel.isHidden = false
            case UIImage(named: "ic_work_receive") :
                cell.headLabel.text = "Assign Date"
                cell.headLabel.isHidden = false
            case UIImage(named: "ic_work_expect"):
                cell.headLabel.text = "SLA Respone"
                cell.headLabel.isHidden = false
            case UIImage(named: "ic_work_sla_fixed"):
                cell.headLabel.text = "SLA Fixd"
                cell.headLabel.isHidden = false
            default : print("HI")
            }
            
            if model.title == Title.ATTACHMENT.rawValue {
                cell.rightIconmainLabel.isHidden = false
                cell.rightIconmainLabel
                    .text = "\(job.attachment.count) file"
                cell.click.isHidden = false
            }
            if model.title == Title.WARRANTY_Owner.rawValue{
                cell.headLabel.text = "Owner"
                cell.mainLabel.text = "\(job.warranty.expire)"
                cell.headLabel.isHidden = false
            }
            if model.title == Title.WARRANTY_Supplier.rawValue{
                cell.headLabel.text = "Supplier"
                cell.mainLabel.text = "\(job.warranty.expireSupplier)"
                cell.headLabel.isHidden = false
            }
            if model.title == Title.GENERAL_Sn.rawValue{
                cell.headLabel.text = "Serail Number"
                cell.mainLabel.text = job.serialNO
                cell.headLabel.isHidden = false
            }
            if model.title == Title.GENERAL_Phone.rawValue{
                cell.headLabel.text = "Name"
                cell.mainLabel.text = job.customer.tel
                cell.headLabel.isHidden = false
                cell.click.isHidden = false
            }
            if model.title == Title.PART_Mp.rawValue{
                if job.warranty.sparePart?.parts == nil {
                    cell.rightIconmainLabel.text = "No Data"
                    
                }else {
                    cell.rightIconmainLabel.text = "\(job.warranty.sparePart?.parts.count ?? 0)"
                }
                cell.rightIconmainLabel.isHidden = false
            }
            if model.title == Title.PART_Mb.rawValue{
                if job.warranty.sparePart?.buffers == nil {
                    cell.rightIconmainLabel.text = "No Data"
                    
                }else {
                    cell.rightIconmainLabel.text = "\(job.warranty.sparePart?.buffers.count ?? 0)"
                }
                cell.rightIconmainLabel.isHidden = false
                
            }
            if model.title == Title.ENGINEER_Accept.rawValue{
                let engCanAccept = job.engineer.filter { acp in
                    return acp.accepted == true
                }
                cell.rightIconmainLabel.text = "\(engCanAccept.count)/\(job.engineer.count)"
                cell.rightIconmainLabel.isHidden = false
                cell.click.isHidden = false
               
            }
            if model.title == Title.ENGINEER_Accept_Button.rawValue{
                cell.engButton.isHidden = false
                cell.mainLabel.isHidden = true
                cell.headLabel.isHidden = true
                cell.engButton.backgroundColor = UIColor(rgb: 0xf75355)
                cell.engButton.layer.cornerRadius = 10
               
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return jobModel.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = jobModel[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0, 7] {
            let alert = UIAlertController(title: "", message: "ต้องการเปิดแผนที่หรือไม่", preferredStyle: UIAlertController.Style.alert)

               
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: { action in
                self.openMapForPlace(lat: self.job?.customer.location.coordinates.lat, lon: self.job?.customer.location.coordinates.lng)
           
            }))
                   self.present(alert, animated: true, completion: nil)
            
            
        }
        
       
           
        
        
  
        print(indexPath)
    }
    
   
   
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = UIColor.gray
//        let label = UILabel()
//        let section = jobModel[section]
//        label.text = section.title
//        label.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
//        view.addSubview(label)
//        return view
//    }
}

extension JobDetailViewController {
    func openMapForPlace(lat:Double? ,lon:Double?) {
           
        guard let lat = lat , let lon = lon else {return}
//           let latitude: CLLocationDegrees = 37.2
//           let longitude: CLLocationDegrees = 22.9
           
           let regionDistance:CLLocationDistance = 10000
           let coordinates = CLLocationCoordinate2DMake(lat, lon)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
           let options = [
               MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
               MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
           ]
           let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
           let mapItem = MKMapItem(placemark: placemark)
           mapItem.name = "Place Name"
           mapItem.openInMaps(launchOptions: options)
       }
}



enum Title: String {
    case ATTACHMENT = "Attached files"
    case WARRANTY = "WARRANTY"
    case WARRANTY_Owner = "Owner"
    case WARRANTY_Supplier = "Supplier"
    case GENERAL = "GENERAL INFO"
    case GENERAL_Sn = "Serail Number"
    case GENERAL_Phone = "Name"
    
    case PART = "PART & BUFFER"
    case PART_Mp = "Manage Part"
    case PART_Mb = "Manage Buffer"
    case ENGINEER = "ACCEPT ENGINEER"
    case ENGINEER_Accept = "Engineer"
    case ENGINEER_Accept_Button = "Button"
}
