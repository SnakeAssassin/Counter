//
//  ViewController.swift
//  Counter
//
//  Created by Joe Kramer on 27.09.2023.
//

import UIKit

class ViewController: UIViewController {

    /// Добавление аутлетов
    @IBOutlet weak var counterImageViev: UILabel!
    @IBOutlet weak var decreaseValueButton: UIButton!
    @IBOutlet weak var increaseValueButton: UIButton!
    @IBOutlet weak var resetValueButton: UIButton!
    @IBOutlet weak var eventLog: UITextView!
    
    /// Установка начального значения счетчика
    private var counter: Int = 0
    
    /// Функция вывода временной метки
    func timestamp() -> (String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        let date = dateFormatter.string(from: Date())
        return date
    }

    /// Функция автоматического скролла текста
    func scroll() {
        // Проверяем, нужно ли прокручивать UITextView
        // Высота всего содержимого внутри TextView > высота видимой области окна TextViev
        if eventLog.contentSize.height > eventLog.bounds.size.height {
            // NSRange выделяет диапазон символов
            // NSRange(location: <#T##Int#>, length: <#T##Int#>), начальный символ (индекс с 0) и длина
            // location: eventLog.text.count - 1 – индекс последнего символа (общее количество - 1)
            // length: 1 – кол-во символов для выделения (т.е. берется последний
            let range = NSRange(location: eventLog.text.count - 1, length: 1)
            // Выделили последний символ и автоматически прокрутили до него, чтобы он был видимым
            eventLog.scrollRangeToVisible(range)
        }
    }
    
    
    
    /// Добавление действий
    /// Нажатие на кнопку "–" убавляет значение, если больше нуля, выводит лог действий и скроллит текст
    @IBAction func tapDecreaseValueButton(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            counterImageViev.text = String(counter)
            eventLog.text += "\(timestamp()): значение изменено на -1\n" }
        else {
            eventLog.text += "\(timestamp()): попытка уменьшить значение счётчика ниже 0\n"
        }
        scroll()
    
    }

    /// Нажатие на кнопку "+" прибавляет значение, выводит лог действий и скроллит текст
    @IBAction func tapIncreaseValueButton(_ sender: Any) {
        counter += 1
        counterImageViev.text = String(counter)
        eventLog.text += "\(timestamp()): значение изменено на +1\n"
        scroll()
    }
    
    /// Нажатие на кнопку "Reset" сбрасывает значение,  выводит лог действий и скроллит текст
    @IBAction func tapResetValueButton(_ sender: Any) {
        counter = 0
        counterImageViev.text = String(counter)
        eventLog.text += "\(timestamp()): значение сброшено\n"
        scroll()
    }
    
    
    

    /// View появилось на экране, вывод начального значения счетчика и текст лога
    override func viewDidLoad() {
        super.viewDidLoad()
        counterImageViev.text = String(counter)
        eventLog.text = "История изменений: \n"
    }
}

