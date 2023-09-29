//
//  ViewController.swift
//  Counter
//
//  Created by Joe Kramer on 27.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    /// Функция вывода временной метки
    private func timestamp() -> (String) {
        let dateFormatter = DateFormatter()                                     // Присваиваем переменной значение функции
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"                           // Задаем вид отображения данных
        let date = dateFormatter.string(from: Date())                           // Преобразовываем значение времени в String
        return date
    }
    
    /// Функция автоматического скролла текста
    private func scroll() {
        if eventLog.contentSize.height > eventLog.bounds.size.height {          // Проверяем, нужно ли прокручивать UITextView
                                                                                // Высота всего содержимого внутри TextView > высота видимой области окна TextViev
                                                                                // NSRange выделяет диапазон символов
                                                                                // NSRange(location: Int, length: Int), начальный символ (индекс с 0) и длина
                                                                                // location: eventLog.text.count - 1 – индекс последнего символа (общее количество - 1)
                                                                                // length: 1 – кол-во символов для выделения (т.е. берется последний
            let range = NSRange(location: eventLog.text.count - 1, length: 1)
            eventLog.scrollRangeToVisible(range)                                // Выделили последний символ и автоматически прокрутили до него, чтобы он был видимым
        }
    }
    
    /// Добавление аутлетов
    @IBOutlet weak private var counterImageViev: UILabel!                       // Аутлет отображения Counter
    @IBOutlet weak private var decreaseValueButton: UIButton!                   // Аутлет кнопки декремента
    @IBOutlet weak private var increaseValueButton: UIButton!                   // Аутлет кнопки инкремента
    @IBOutlet weak private var resetValueButton: UIButton!                      // Аутлет кнопки сброса значений
    @IBOutlet weak private var eventLog: UITextView!                            // Аутлет текстового лога событий
    
    /// Установка начального значения счетчика
    private var counter: Int = 0
    
    /// Добавление действий
    /// Нажатие на кнопку "–" убавляет значение, если больше нуля, выводит лог действий и скроллит текст
    @IBAction private func tapDecreaseValueButton(_ sender: Any) {
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
    @IBAction private func tapIncreaseValueButton(_ sender: Any) {
        counter += 1
        counterImageViev.text = String(counter)
        eventLog.text += "\(timestamp()): значение изменено на +1\n"
        scroll()
    }
    
    
    /// Нажатие на кнопку "Reset" сбрасывает значение,  выводит лог действий и скроллит текст
    @IBAction private func tapResetValueButton(_ sender: Any) {
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
