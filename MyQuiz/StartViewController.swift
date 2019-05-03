//
//  StartViewController.swift
//  MyQuiz
//
//  Created by 坂口豪紀 on 2019/05/03.
//  Copyright © 2019 Goki Sakaguchi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 次の画面に遷移する前に呼び出される準備処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        
        // 遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // 取得できずに終了
            return
        }
        
        // 問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQustion() else {
            // 取得できずに終了
            return
        }
        
        // 問題文のセット
        nextViewController.questionData = questionData
    }
    
    @IBAction func goTitle(_ segue: UIStoryboardSegue){
        
    }

}
