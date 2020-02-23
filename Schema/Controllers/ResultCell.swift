//
//  ResultCell.swift
//  YSQ
//
//  Created by Itay Garbash on 02/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var schemeLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func setData(with result: ResultsModel, indexPath: IndexPath, info: Info) {
        
        //let score = Int(Double((result.resultArray[indexPath.row] / (QuestionModel().questions.count / 18)) - 1) * (100.0 / 5.0)
    
        let top = result.resultArray[indexPath.row] - (QuestionModel.shared.questions.count / 18)
        let bottom = ((QuestionModel.shared.questions.count / 18) * 5)
        let score = (Double(top) / Double(bottom)) * 100
        
        schemeLabel.text = info.titles[indexPath.row]
        percentageLabel.text = "\(Int(score))%"
        progressView.progress = Float(score) / 100.0
    }
    
    
}
