//
//  HeroesList.swift
//  Dota2Heroes
//
//  Created by Kresimir Ivanjko on 23.04.2023..
//

import Foundation

struct Hero: Codable {
    let id: Int?
    let name: String?
    let localized_name: String?
    let primary_attr: String?
    let attack_type: String?
    let img: String
    let icon: String
}
/*
 
 {
   "id": 1,
   "name": "npc_dota_hero_antimage",
   "localized_name": "Anti-Mage",
   "primary_attr": "agi",
   "attack_type": "Melee",
   "roles": [
     "Carry",
     "Escape",
     "Nuker"
   ],
   "img": "/apps/dota2/images/dota_react/heroes/antimage.png?",
   "icon": "/apps/dota2/images/dota_react/heroes/icons/antimage.png?",
   "base_health": 200,
   "base_health_regen": 0.25,
   "base_mana": 75,
   "base_mana_regen": 0,
   "base_armor": 0,
   "base_mr": 25,
   "base_attack_min": 29,
   "base_attack_max": 33,
   "base_str": 21,
   "base_agi": 24,
   "base_int": 12,
   "str_gain": 1.6,
   "agi_gain": 2.8,
   "int_gain": 1.8,
   "attack_range": 150,
   "projectile_speed": 0,
   "attack_rate": 1.4,
   "base_attack_time": 100,
   "attack_point": 0.3,
   "move_speed": 310,
   "turn_rate": null,
   "cm_enabled": true,
   "legs": 2,
   "day_vision": 1800,
   "night_vision": 800,
   "hero_id": 1,
   "turbo_picks": 683219,
   "turbo_wins": 373949,
   "pro_ban": 762,
   "pro_win": 135,
   "pro_pick": 277,
   "1_pick": 25189,
   "1_win": 13553,
   "2_pick": 62152,
   "2_win": 33457,
   "3_pick": 65666,
   "3_win": 34930,
   "4_pick": 51124,
   "4_win": 27261,
   "5_pick": 29410,
   "5_win": 15313,
   "6_pick": 14108,
   "6_win": 7320,
   "7_pick": 7539,
   "7_win": 3893,
   "8_pick": 3096,
   "8_win": 1551,
   "null_pick": 2065165,
   "null_win": 0
 */
