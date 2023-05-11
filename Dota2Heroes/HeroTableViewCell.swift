//
//  HeroTableViewCell.swift
//  Dota2Heroes
//
//  Created by Kresimir Ivanjko on 26.04.2023..
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var localizedName: UILabel!
    @IBOutlet var primaryAttr: UILabel!
    @IBOutlet var attackType: UILabel!
    @IBOutlet var attributeImage: UIImageView!
    @IBOutlet var heroesRoles: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    // MARK: - Attribute image
    
    func configureAttributeImage(for heroes: Hero) {
        localizedName.text = heroes.localized_name
        
        switch heroes.primary_attr {
        case "str":
            attributeImage.image = UIImage(named: "strength.attribute")
            primaryAttr.text = "Strength"
        case "agi":
            attributeImage.image = UIImage(named: "agility.attribute")
            primaryAttr.text = "Agility"
        case "int":
            attributeImage.image = UIImage(named: "intelligence.attribute")
            primaryAttr.text = "Intelligence"
        default:
            attributeImage.image = UIImage(systemName: "circle.circle")
            primaryAttr.text = "Universal"
        }
    }
}

