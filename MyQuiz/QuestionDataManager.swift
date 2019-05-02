//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by 坂口豪紀 on 2019/05/02.
//  Copyright © 2019 Goki Sakaguchi. All rights reserved.
//

import Foundation

// 1つの問題に関する情報を格納するデータクラス
class QuestionData {
    
    // 問題文
    var question: String
    
    // 選択肢
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    // 正解の番号
    var correctAnswerNumber: Int
    
    // ユーザーが選択した選択肢の番号
    var userChoiceAnswerNumber: Int?
    
    // 問題の番号
    var questionNo: Int = 0
    
    // クラスが生成されたときの処理
    init(qustionSourceDataArray: [String]) {
        question = qustionSourceDataArray[0]
        answer1 = qustionSourceDataArray[1]
        answer2 = qustionSourceDataArray[2]
        answer3 = qustionSourceDataArray[3]
        answer4 = qustionSourceDataArray[4]
        correctAnswerNumber = Int(qustionSourceDataArray[5])!
    }
    
    
    // ユーザーが選択したと答えが正解かどうか判定する
    func isCorrect() -> Bool {
        // 答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiceAnswerNumber {
            // 正解
            return true
        }
        
        // 不正解
        return false
    }
    
}


// クイズデータ全般の管理と成績を管理するクラス
class QuestionDataManager {
    
    // シングルトンのオブジェクトを生成
    static let sharedInstance = QuestionDataManager()
    
    // 問題を格納するための配列
    var questionDataArray = [QuestionData]()
    
    // 現在の問題のインデックス
    var nowQuestionIndex: Int = 0
    
    // 初期化処理
    private init() {
        // シングルトンであることを保証するためにprivateで宣言
    }
    
    // 問題文の読み込み処理
    func loadQuestion() {
        // 格納済みの問題文があればいったん削除する
        questionDataArray.removeAll()
        
        // 現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        
        // csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            // csvファイルなし
            print("csvファイルが存在しません")
            return
        }
        
        // csvファイル読み込み
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            // csvデータを1行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line, stop) in
                // カンマ区切りで分割
                let qustionSourceDataArray = line.components(separatedBy: ",")
                // 問題データを格納するオブジェクトを作成
                let qustionData = QuestionData(qustionSourceDataArray: qustionSourceDataArray)
                // 問題を追加
                self.questionDataArray.append(qustionData)
                // 問題番号を設定
                qustionData.questionNo = self.questionDataArray.count
            })
        } catch let error {
            print("csvファイル読み込みエラーが発生しました:\(error)")
            return
        }
    }
    
    // 次の問題を取り出す
    func nextQustion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
    
}
