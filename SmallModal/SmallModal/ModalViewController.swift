//
//  ModalViewController.swift
//  SmallModal
//
//  Created by 김진웅 on 2022/08/15.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var modalViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scheduleTextField: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var exitDatePicker: UIDatePicker!
    
    @IBOutlet weak var memoTextField: UITextField!
    
    var scheduleTitle: String = ""
    var startDate: String = ""
    var exitDate: String = ""
    var memo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalStyle()
        oneHourPlus()
        dateInit()
        
        scheduleTextField.delegate = self
        memoTextField.delegate = self
    }
    
    // 초기 모달 설정
    func modalStyle() {
        // 모달이 보이지 않게 높이를 초기화
        modalViewHeight.constant = 0
        
        // 배경화면 투명도 조절
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    // 모달이 올라오는 애니메이션 지정
    func modalAnimation() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.modalViewHeight.constant = 600
            
            self.view.layoutIfNeeded()
        }
    }
    
    // 기본 종료 시간을 현재 시간에서 한시간 후로 설정하기 위해..
    private func oneHourPlus() {
        exitDatePicker.date = Date()+3600
    }
    
    // startDate, exitDate 초기화
    private func dateInit() {
        let date = Date()
        let oneHourPlus = Date()+3600
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        startDate = formatter.string(from: date)
        exitDate = formatter.string(from: oneHourPlus)
    }
    
    // 입력이 끝나고 화면 빈 곳을 터치했을 때 키보드가 사라지게끔..
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scheduleTextField.resignFirstResponder()
        self.memoTextField.resignFirstResponder()
        
        
    }
    
    // 시작 날짜 고르기
    @IBAction func changeStartDate(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        formatter.locale = Locale(identifier: "ko_KR")
        startDate = formatter.string(from: datePickerView.date)
        print(">>> 시작 날짜 : \(startDate)")
    }
    
    // 종료 날짜 고르기
    @IBAction func changeExitDate(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        exitDate = formatter.string(from: datePickerView.date)
        print(">>> 종료 날짜 : \(exitDate)")
    }
    
    // 저장 버튼 눌렀을 때
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        scheduleTitle = scheduleTextField.text ?? ""
        memo = memoTextField.text ?? ""
        var date = Date()
        print(">>> 일정 제목 : \(scheduleTitle)")
        print(">>> 일정 시작 : \(startDate)")
        print(">>> 일정 종료 : \(exitDate)")
        print(">>> 메모 : \(memo)")
        
        self.dismiss(animated: true)
    }
    // 취소 버튼 눌렸을 때
    @IBAction func cancelButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.modalViewHeight.constant = 0
            self.view.layoutIfNeeded()
            
            self.dismiss(animated: true)
        }
    }
    
}

// 키보드에서 done이 눌렸을 때 키보드가 사라지게 함
extension ModalViewController:UITextFieldDelegate {
    // 키보드 자동으로 올라오기
    override func viewWillAppear(_ animated: Bool) {
        self.scheduleTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scheduleTextField.endEditing(true)
        memoTextField.endEditing(true)
        return true
    }
}
