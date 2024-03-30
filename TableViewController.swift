//
//  TableViewController.swift
//  Login_Demo
//
//  Created by  Abdul Quadir on 09/03/24.
//

import UIKit

class TableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    	
 
    @IBOutlet weak var tableview: UITableView!
    
    
    var arrData = [apiKeyData]()

    struct apiKeyData: Codable {
        var name: String
        var year: Int
        var color: String
        var pantone_value: String
    }

    struct APIResponse: Codable {
        let page: Int
        let per_page: Int
        let total: Int
        let total_pages: Int
        let data: [apiKeyData]
    }
    struct SupportInfo: Codable {
        var url: String
        var text: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
// fetch data from api
    func getData() {
        let session = URLSession.shared
        let serviceURL = URL(string: "https://reqres.in/api/login2345")
        let task = session.dataTask(with: serviceURL!) { mydata, myresponse, error in
            print("ok")
            if error == nil {
                if let httpResponse = myresponse as? HTTPURLResponse {
                    print("ok")

                    if (httpResponse.statusCode == 200) {
                        print("ok")

                        do {
                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode(APIResponse.self, from: mydata!)
                            print("ok")

                            self.arrData = responseData.data

                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                            }
                            
                        } catch {
                            print("Error decoding data: \(error)")
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return arrData.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableTableViewCell
        let data = arrData[indexPath.row]
        
        cell?.name?.text = data.name
        cell?.value.text = data.pantone_value
        cell?.year?.text = "Year: \(data.year)"
        cell?.img.backgroundColor = UIColor(hexString: data.color)
        
        return cell!
    }
   
    }

    
 // for imgview background color change
extension UIColor {
    convenience init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
