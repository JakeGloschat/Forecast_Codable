//
//  DayDetailsViewController.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var days: [Day] = []
    var forecastData: TopLevelDictionary?
    
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayForcastTableView.dataSource = self
        dayForcastTableView.delegate   = self
        
        fetchWeather()
    }
    
    
    func fetchWeather() {
        NetworkController.fetchDays { forecastData in
            guard let forecastData = forecastData else { return }
            self.forecastData = forecastData
            self.days = forecastData.days
            DispatchQueue.main.async {
                self.cityNameLabel.text = forecastData.cityName
                self.updateViews()
                self.dayForcastTableView.reloadData()
            }
        }
    }
    
    //MARK: - FUNCTIONS
    func updateViews() {
        let today = days[0]
        currentTempLabel.text = "\(today.temp)°F"
        currentHighLabel.text = "\(today.highTemp)°F"
        currentLowLabel.text  = "\(today.lowTemp)°F"
        currentDescriptionLabel.text = today.weather.description
    }
}

//MARK: - Extenstions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else { return UITableViewCell() }
        
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        
        return cell
    }
}

