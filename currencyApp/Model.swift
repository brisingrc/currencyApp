//
//  Model.swift
//  currencyApp
//
//  Created by Мак on 8/7/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit


//<item><fullname>АВСТРАЛИЙСКИЙ ДОЛЛАР</fullname><title>AUD</title><description>95.29</description><quant>1</quant><index/><change>0.00</change></item>
class Currency {
    var fullname: String?
    var title: String?
    
    var description: String?
    var descriptionDouble: Double?
    
    var change: String?
    var changeDouble: Double?
    
    var quant: String?
    var quantDouble: Double?
    
    var imageFlag: UIImage?{
        if let title = title {
            return UIImage(named: title + ".png")
        }
        return nil
    }
    
    class func tenge() -> Currency {
        let kz = Currency()
        kz.fullname = "КАЗАХСТАНСКИЙ ТЕНГЕ"
        kz.title = "KZT"
        kz.quant = "1"
        kz.quantDouble = 1
        kz.description = "1.00"
        kz.descriptionDouble = 1
        kz.change = "1"
        kz.changeDouble = 1
        return kz
    }
}



class Model: NSObject, XMLParserDelegate {
static let shared = Model()
    
    var currencies: [Currency] = []
    var currentDate: Date = Date()
    
    
//    var currentDate: String = ""
    var from: Currency = Currency.tenge()
    var to: Currency = Currency.tenge()
    
    func convert(amount: Double?) -> String {
        if amount == nil {
            return ""
        }
        let d = ((from.quantDouble! * from.descriptionDouble!) / (to.quantDouble! * to.descriptionDouble!)) * amount!
        return String(d)
    }
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
        
        if FileManager.default.fileExists(atPath: path){
            return path
        }
        return Bundle.main.path(forResource: "data", ofType: "xml")!
    }
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    // https://nationalbank.kz/rss/get_rates.cfm?fdate=23.02.2009
    func loadXMLFile(date:Date?){
        var strUrl = "https://nationalbank.kz/rss/get_rates.cfm?"
        
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            strUrl = strUrl + "fdate=" + dateFormatter.string(from: date!)
        }
        
        let url = URL(string: strUrl)
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
                let urlForSave = URL(fileURLWithPath: path)
                do {
                     try data?.write(to: urlForSave)
                    print("Файл загружен")
                    self.parseXML()
                } catch {
                    print("Error when save data"+error.localizedDescription)

                }
                            } else {
                print("Error when loadXMLFile:")
            }
        }
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
        task.resume()
    }
    func parseXML(){
        currencies = [Currency.tenge()]
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        print("Данные обновлены")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadingXML"), object: self)
        for c in currencies {
            if c.title == from.title {
                from = c
            }
            if c.title == to.title {
                to = c
            }
        }
    }
    
    var currentCurrency: Currency?
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if elementName == "rates"{
            if let currentDateString = attributeDict["date"]{
               let df = DateFormatter()
                df.dateFormat = "dd.MM.yyyy"
                currentDate = df.date(from: currentDateString)!
               // currentDate = currentDateString
                }
        
        }
        if elementName == "item"{
            currentCurrency = Currency()
        }
    }
    
    //<item><fullname>АВСТРАЛИЙСКИЙ ДОЛЛАР</fullname><title>AUD</title><description>95.29</description><quant>1</quant><index/><change>0.00</change></item>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if elementName == "fullname"{
            currentCurrency?.fullname = currentCharacters
        }
        if elementName == "title"{
            currentCurrency?.title = currentCharacters
        }
        if elementName == "description"{
            currentCurrency?.description = currentCharacters
            currentCurrency?.descriptionDouble = Double(currentCharacters)
        }
        if elementName == "change"{
            currentCurrency?.change = currentCharacters
            currentCurrency?.changeDouble = Double(currentCharacters)
        }
        if elementName == "quant"{
            currentCurrency?.quant = currentCharacters
            currentCurrency?.quantDouble = Double(currentCharacters)
        }
        
        
        if elementName == "item"{
            currencies.append(currentCurrency!)
        }
    }
    
    var currentCharacters: String = ""
    func parser(_ parser: XMLParser, foundCharacters string: String){
        currentCharacters = string
    }

}
