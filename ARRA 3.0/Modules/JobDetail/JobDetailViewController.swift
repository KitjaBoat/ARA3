//
//  JobDetailViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit
import MapKit

class JobDetailViewController: UIViewController {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var job:JobDetail?
    var jobSection = [Section]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "CustomeCell", bundle: nil), forCellReuseIdentifier: "CustomeCell")
     
        setupTableView()

    }
    
    func setupTableView() {
        guard let job = job else {
            return
        }
        
        jobSection.append(Section(title: job.jobTitle , value: [
            JobToSetupTableView(title: job.getJobStatus()?.detail ?? "", icon: job.getJobStatus()?.getIcon()),
            JobToSetupTableView(title: "\(job.timeline?.opened)", icon: UIImage(named: "ic_work_open")),
//            JobToSetupTableView(title: "\(job.timeline!.assignment)", icon: UIImage(named: "ic_work_receive")),
            JobToSetupTableView(title: "\(job.timeline?.condition?.slaResponse)", icon: UIImage(named: "ic_work_expect")),
//            JobToSetupTableView(title: "\(job.timeline!.condition.slaFixed)", icon: UIImage(named: "ic_work_sla_fixed")),
            JobToSetupTableView(title: job.problem , icon: UIImage(named: "ic_work_problem")),
            JobToSetupTableView(title: job.dispatcherRecommend ?? "", icon: UIImage(named: "ic_chat")),
            JobToSetupTableView(title: job.customer.location.address , icon: UIImage(named: "ic_work_location")),
            JobToSetupTableView(title: job.contactRemark ?? "", icon: UIImage(named: "ic_work_remark"))
        ]))
        
        
        jobSection.append(Section(title: Title.ATTACHMENT.rawValue, value: [
                        JobToSetupTableView(title: Title.ATTACHMENT.rawValue, icon: nil)
                        ]))

        jobSection.append(Section(title: Title.WARRANTY.rawValue, value: [
            JobToSetupTableView(title: Title.WARRANTY_Owner.rawValue, icon: nil),
            JobToSetupTableView(title: Title.WARRANTY_Supplier.rawValue, icon: nil)
        ]))
        
        jobSection.append(Section(title: Title.GENERAL.rawValue, value:[
            JobToSetupTableView(title: Title.GENERAL_Sn.rawValue, icon: UIImage(named: "ic_work_serial")),
            JobToSetupTableView(title: Title.GENERAL_Phone.rawValue, icon: UIImage(named: "ic_work_phone"))
        ]))
        
        jobSection.append(Section(title: Title.PART.rawValue, value: [
            JobToSetupTableView(title: Title.PART_Mp.rawValue, icon: nil),
            JobToSetupTableView(title: Title.PART_Mb.rawValue, icon: nil)
        ]))
        
        jobSection.append(Section(title: Title.ENGINEER.rawValue, value: [
            JobToSetupTableView(title: Title.ENGINEER_Accept.rawValue, icon: nil),
            JobToSetupTableView(title: Title.ENGINEER_Accept_Button.rawValue, icon: nil)
            ]))
        
        tableView.reloadData()
       
    }

}

extension JobDetailViewController:UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return jobSection[section].value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomeCell", for: indexPath) as! CustomeCell
            let model = jobSection[indexPath.section].value[indexPath.row]
            cell.rightIcon.isHidden = true
            cell.rightIconmainLabel.isHidden = true
            cell.mainLabel.text = model.title
            cell.icon.image = model.icon
            cell.click.isHidden = true
            cell.headLabel.isHidden = true
            cell.engButton.isHidden = true
            cell.rightmainLabel.isHidden = true
            cell.rightHeadLabel.isHidden = true
            cell.rightIconMain.isHidden = true
        
        
        //            JobToSetupTableView(title: "\(job.timeline!.assignment)", icon: UIImage(named: "ic_work_receive")),
        
        //            JobToSetupTableView(title: "\(job.timeline!.condition.slaFixed)", icon: UIImage(named: "ic_work_sla_fixed")),
        
        
        
        
            if let job = job {
                switch model.icon {
                case job.getJobStatus()?.getIcon():
                    cell.headLabel.text = "Job status"
                    cell.headLabel.isHidden = false
                case UIImage(named: "ic_work_open"):
                    cell.headLabel.text = "Open Date"
                    cell.rightHeadLabel.text = "Assign Date"
                    cell.rightmainLabel.text =  "\(job.timeline?.assignment ?? 0)"
                    cell.rightIconMain.image = UIImage(named: "ic_work_receive")
                    cell.headLabel.isHidden = false
                    cell.rightmainLabel.isHidden = false
                    cell.rightHeadLabel.isHidden = false
                    cell.rightIconMain.isHidden = false
//                case UIImage(named: "ic_work_receive") :
//                    cell.headLabel.text = "Assign Date"
//                    cell.headLabel.isHidden = false
                case UIImage(named: "ic_work_expect"):
                    cell.headLabel.text = "SLA Respone"
                    cell.rightHeadLabel.text = "SLA Fixd"
                    cell.rightmainLabel.text =  "\(job.timeline?.condition?.slaFixed ?? 0)"
                    cell.rightIconMain.image = UIImage(named: "ic_work_sla_fixed")
                    cell.headLabel.isHidden = false
                    cell.rightmainLabel.isHidden = false
                    cell.rightHeadLabel.isHidden = false
                    cell.rightIconMain.isHidden = false
//                case UIImage(named: "ic_work_sla_fixed"):
//                    cell.headLabel.text = "SLA Fixd"
//                    cell.headLabel.isHidden = false
                default : break
                }
                
                if model.title == Title.ATTACHMENT.rawValue {
                    cell.rightIconmainLabel.isHidden = false
                    cell.rightIconmainLabel
                    .text = "\(job.attachment?.count ?? 0) file"
                    cell.click.isHidden = false
                }
                if model.title == Title.WARRANTY_Owner.rawValue{
                    cell.headLabel.text = "Owner"
                    cell.mainLabel.text = "\(job.warranty?.expire ?? 0)"
                    cell.headLabel.isHidden = false
                }
                if model.title == Title.WARRANTY_Supplier.rawValue{
                    cell.headLabel.text = "Supplier"
                    cell.mainLabel.text = "\(job.warranty?.expireSupplier ?? 0)"
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
                    if job.warranty?.sparePart?.parts == nil {
                        cell.rightIconmainLabel.text = "No Data"
                        
                    }else {
                        cell.rightIconmainLabel.text = "\(job.warranty?.sparePart?.parts.count ?? 0)"
                    }
                    cell.rightIconmainLabel.isHidden = false
                }
                if model.title == Title.PART_Mb.rawValue{
                    if job.warranty?.sparePart?.buffers == nil {
                        cell.rightIconmainLabel.text = "No Data"
                        
                    }else {
                        cell.rightIconmainLabel.text = "\(job.warranty?.sparePart?.buffers.count ?? 0)"
                    }
                    cell.rightIconmainLabel.isHidden = false
                    
                }
                if model.title == Title.ENGINEER_Accept.rawValue{
                    
                    let engCanAccept = job.engineer?.filter { acp in
                        return acp.accepted == true
                    }
                    
                    cell.rightIconmainLabel.text = "\(engCanAccept?.count ?? 0)/\(job.engineer?.count ?? 0)"
                    cell.rightIconmainLabel.isHidden = false
                    cell.click.isHidden = false
                }
                
                if model.title == Title.ENGINEER_Accept_Button.rawValue {
                    cell.rightmainLabel.text = "Tab"
                    cell.rightmainLabel.isHidden = false
                    cell.backgroundColor = UIColor(rgb: 0xf75355)
                    cell.rightmainLabel.textColor = .white
                    
                }
            }
            
            return cell
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableView {
            return jobSection.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = jobSection[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // map
        if indexPath == [0, 5] {
            let alert = UIAlertController(title: "", message: "ต้องการเปิดแผนที่หรือไม่", preferredStyle: UIAlertController.Style.alert)

               
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: { action in
                self.openMapForPlace(lat: self.job?.customer.location.coordinates.lat, lon: self.job?.customer.location.coordinates.lng)
           
            }))
                   self.present(alert, animated: true, completion: nil)
        }
        // Attach File
        else if indexPath == [1, 0] {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AttachFileViewController") as! AttachFileViewController
            vc.attachFileList = job?.attachment
            navigationController?.pushViewController(vc, animated: true)
            
        }
        // Tel
        else if indexPath == [3, 1] {
            let alert = UIAlertController(title: "", message: "ต้องการโทรหรือไม่", preferredStyle: UIAlertController.Style.alert)

               
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: { action in
                self.callNumber(phoneNumber: self.job?.customer.tel ?? "00")
           
            }))
                   self.present(alert, animated: true, completion: nil)
        }
       
        else if indexPath == [5, 0] {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ManageEngineerViewController") as! ManageEngineerViewController
            vc.engineerList = job?.engineer
            navigationController?.pushViewController(vc, animated: true)
            
        }
        print(indexPath)
    }
    
    private func callNumber(phoneNumber:String) {
      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
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

//extension JobDetailViewController:MenuControllerDeleger {
//    func cellDidTap(module: String) {
//        
//    }
//    
//    
//}



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
