import Foundation
import UIKit

class MainViewController: UIViewController {
    
    let segmentControl: UISegmentedControl = {
        
        let items = ["closer to center", "more available rooms"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.tintColor = .black
        segmentedControl.backgroundColor = .white
        
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    let hotelsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: "MainTableViewCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var presenter: MainViewPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotelsTableView.tableHeaderView = segmentControl
        
        view.addSubview(hotelsTableView)
        
        setupTableViewConstraints()
        
        hotelsTableView.delegate = self
        hotelsTableView.dataSource = self
    }
    
    func setupTableViewConstraints() {
        hotelsTableView.translatesAutoresizingMaskIntoConstraints = false
        hotelsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hotelsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hotelsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hotelsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.showHotels(segmentIndex: segmentControl.selectedSegmentIndex)
    }
    
    // MARK: - Actions
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        presenter.showHotels(segmentIndex: segmentedControl.selectedSegmentIndex)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.hotels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        cell.selectionStyle = .none
        
        let hotel = presenter.hotels[indexPath.section]
        cell.hotelName.text = hotel.name
        cell.locationLabel.text = "\(hotel.adress)"
        cell.hotelStars.text = "\(hotel.stars)"
        
        if let stringURL = hotel.imageUrl, let imageURL = URL(string: stringURL) {
            cell.hotelImageView.loadImage(with: imageURL)
        } else {
            cell.hotelImageView.image = UIImage(named: "default")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotel = presenter.hotels[indexPath.section]
        presenter.tapOnTheHotel(hotel: hotel)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func setHotels() {
        hotelsTableView.reloadData()
    }
}
