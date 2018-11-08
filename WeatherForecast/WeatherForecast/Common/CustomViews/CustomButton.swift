//
//  CustomButton.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case submit
}

class CustomButton: UIButton {
    
    var touchUp: ((CustomButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        self.addTarget(self, action: #selector(CustomButton.touchUp(_:)), for: .touchUpInside)
    }
    
    func setButtonStyle(_ style: ButtonStyle) {
        switch style {
        case .submit:
            setTitle("\u{f0a9}", for: .normal)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont(name: "FontAwesome", size: 28)
        }
    }

    // MARK: - Actions
    
    @objc func touchUp(_ sender: CustomButton) {
        touchUp?(sender)
    }
}
