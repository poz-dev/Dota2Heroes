//
//  ViewController.swift
//  Dota2Heroes
//
//  Created by Kresimir Ivanjko on 23.04.2023..
//

import UIKit

class ViewController: UIViewController {
    var heroes = [Hero]()
   
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var searchHero: UISearchBar!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           fetchHeroStats()
        
       }
       
       func fetchHeroStats() {
           let url = URL(string: "https://api.opendota.com/api/heroStats")!
          
           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   print(error?.localizedDescription ?? "Unknown error")
                   return
               }
               do {
                   self.heroes = try JSONDecoder().decode([Hero].self, from: data)
                   DispatchQueue.main.async {
                       self.myTableView.reloadData()
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
           let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                     let mimeType = response?.mimeType, mimeType.hasPrefix("img"),
                     let data = data, error == nil,
                     let img = UIImage(data: data) else {
                   return
               }
               DispatchQueue.main.async {
                   self.image = img
               }
           }
           dataTask.resume()
       }
   }

   extension ViewController: UITableViewDataSource, UITableViewDelegate {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return heroes.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
           cell.localizedName.text = heroes[indexPath.row].localized_name
           cell.primaryAttr.text = heroes[indexPath.row].primary_attr
           cell.attackType.text = heroes[indexPath.row].attack_type
           let hero = heroes[indexPath.row]
           cell.configureAttributeImage(for: hero)
           fetchHeroImages(for: hero) { image in
               DispatchQueue.main.async {
                   cell.heroImage.image = image
               }
           }
           return cell
           
       }
       
       func fetchHeroImages(for hero: Hero, completion: @escaping (UIImage?) -> Void) {
           guard let heroName = hero.localized_name else {
               completion(nil)
               return
           }
           
           let heroImageName = heroName.lowercased().replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "")
           let urlString = "https://api.opendota.com/apps/dota2/images/dota_react/heroes/\(heroImageName).png"
           
           guard let url = URL(string: urlString) else {
               completion(nil)
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, _, error in
               if let error = error {
                   print(error.localizedDescription)
                   completion(nil)
                   return
               }
               
               if let data = data, let image = UIImage(data: data) {
                   completion(image)
               } else {
                   completion(nil)
               }
           }.resume()
       }
   }
