//
//  ImageSearchTableViewCell.swift
//  FlickerGallery
//
//  Created by Admin on 19/04/2022.
//

import UIKit

class ImageSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.titleLbl.text = ""
        self.searchImageView.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
