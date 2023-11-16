//
//  ViewController.swift
//  RestCountriesApp
//
//  Created by Anastasiya Omak on 15/11/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellID = "cell"
    private let countryAllUrl = "https://restcountries.com/v3.1/all"
    private var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        NetworkManager.fetchData(url: countryAllUrl) {
            countries in
            self.countries = countries
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: cellID)
        setupNavigationBar()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender: )))
        view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint){
                basicActionSheet(title: countries[indexPath.row].name.common, message: String("Population: \(countries[indexPath.row].population)"))
            }
        }
    }
        
    private func setupNavigationBar() {
        
        self.title = "Countries"
        let titleImage = UIImage(systemName: "mappin.and.ellipse")
        let imageView = UIImageView(image: titleImage)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        
        
        let darkModeButtonImage = UIImage(systemName: "gearshape")
        let darkModeButton = UIBarButtonItem(image: darkModeButtonImage, style: .plain, target: self, action: #selector(darkModePressed))
        
        navigationItem.rightBarButtonItem = darkModeButton
        
        
        let infoImage = UIImage(systemName: "info.circle.fill")
        let infoButton = UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(infoPressed))
        
        navigationItem.leftBarButtonItem = infoButton

    }
    
    @objc private func darkModePressed(){
        openSettingAction()
    }
    
    @objc private func infoPressed(){
        basicActionSheet(title: "Info", message: "The RestCountriesApp is the 9th project in the iOS Bootcamp by Accenture. The project is authored by Anastasiya Omak.")
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for:indexPath  as IndexPath)
        cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle,reuseIdentifier: cellID)
        
        let country = self.countries[indexPath.row]
        cell.textLabel?.text = country.name.common
        cell.detailTextLabel?.text = country.name.official
        cell.imageView?.image = UIImage()
        
        return cell
    }
}




extension ViewController {
    private func basicActionSheet(title: String?, message: String?){
        DispatchQueue.main.async {
            let actionSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true)
        }
    }
    
    private func openSettingAction(){
        DispatchQueue.main.async {
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
            }

        }
    }
}
