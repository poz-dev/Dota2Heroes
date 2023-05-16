//
//  ViewController.swift
//  Dota2Heroes
//
//  Created by Kresimir Ivanjko on 23.04.2023..
//

import UIKit

class ViewController: UIViewController {
    var heroes = [Hero]()
    var filteredHeroes = [Hero]()
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var searchHero: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHeroStats()
        searchHero.delegate = self
    }
    
    func fetchHeroStats() {
        let url = URL(string: "https://api.opendota.com/api/heroStats")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            do {
                self?.heroes = try JSONDecoder().decode([Hero].self, from: data)
                self?.filteredHeroes = self?.heroes ?? []
                DispatchQueue.main.async {
                    self?.myTableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension UIImageView {
    func downloadImage(from url: URL) {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
        let hero = filteredHeroes[indexPath.row]
        cell.localizedName.text = hero.localized_name
        cell.primaryAttr.text = hero.primary_attr
        cell.attackType.text = hero.attack_type
        cell.configureAttributeImage(for: hero)
        if let heroName = hero.localized_name?.lowercased().replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "") {
              let imageUrl = "https://api.opendota.com/apps/dota2/images/heroes/\(heroName)_full.png"
              if let url = URL(string: imageUrl) {
                  DispatchQueue.global().async {
                      if let data = try? Data(contentsOf: url) {
                          DispatchQueue.main.async {
                              cell.heroImage.image = UIImage(data: data)
                          }
                      }
                  }
              }
          }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // If search text is empty, show all heroes
            filteredHeroes = heroes
        } else {
            // Filter the heroes array based on consecutive letters typed
            filteredHeroes = heroes.filter { hero in
                guard let name = hero.localized_name?.lowercased() else {
                    return false
                }
                
                var currentIndex = name.startIndex
                let searchText = searchText.lowercased()
                
                for char in searchText {
                    let range = currentIndex..<name.endIndex
                    guard let foundRange = name.range(of: String(char),
                                                      options: .caseInsensitive,
                                                      range: range,
                                                      locale: nil) else {
                        return false
                    }
                    currentIndex = foundRange.upperBound
                }
                
                return true
            }
        }
        
        myTableView.reloadData()
    }
}
