//
//  TableViewCell.swift
//  todoy
//
//  Created by Amgad ElNezamy on 30/03/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var noteLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
