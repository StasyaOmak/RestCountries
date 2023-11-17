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
                
                countryInfoAlert(for: countries[indexPath.row])

            }
        }
    }
    
    private func countryInfoAlert (for country: Country) {
        let alert = UIAlertController(
            title: country.name.common,
            message: "Capital: \(country.capital?.joined() ?? "error")\n Population: \(String(country.population))\n Region: \(country.region)",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func infoPressed(){
        let alert = UIAlertController(
            title: "Info",
            message: "The RestCountriesApp is the 9th project in the iOS Bootcamp by Accenture. The project is authored by Anastasiya Omak",
            preferredStyle: .actionSheet
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.configureUI(with: country)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for:indexPath  as IndexPath)
        cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle,reuseIdentifier: cellID)
        
        
        let country = self.countries[indexPath.row]
        
        cell.textLabel?.text = country.name.common
        cell.detailTextLabel?.text = country.name.official
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 15)
        cell.detailTextLabel?.numberOfLines = 0
        
        
        // MARK: - ImageCell
        
        if let url = URL(string: country.flags.png) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data)?.sd_resizedImage(with: CGSize(width: 40.0, height: 40.0) , scaleMode: .aspectFit) {
                        cell.imageView?.image = image
                    }
                }
            }
        
        return cell
    }
}
    
    private func openSettingAction(){
        
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        } else {
            print("Error: Invalid value UIApplication.openSettingsURLString")
        }
    }
