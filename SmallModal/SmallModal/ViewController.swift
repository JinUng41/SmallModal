//
//  ViewController.swift
//  SmallModal
//
//  Created by 김진웅 on 2022/08/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as? ModalViewController else { return }
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = . overFullScreen
        
        self.present(vc, animated: false) {
            DispatchQueue.main.async {
                vc.modalAnimation()
            }
        }
    }
}

