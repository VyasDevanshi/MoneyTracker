//
//  ViewController.swift
//  MoneyTracker
//
//  Created by Mac on 15/12/1944 Saka.

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var countrySelect: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var emailId: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var countryList = ["Afghanistan",
                       "Albania",
                       "Algeria",
                       "American Samoa",
                       "Andorra",
                       "Angola",
                       "Anguilla",
                       "Antarctica",
                       "Antigua and Barbuda",
                       "Argentina",
                       "Armenia",
                       "Aruba",
                       "Australia",
                       "Austria",
                       "Azerbaijan",
                       "Bahamas (the)",
                       "Bahrain",
                       "Bangladesh",
                       "Barbados",
                       "Belarus",
                       "Belgium",
                       "Belize",
                       "Benin",
                       "Bermuda",
                       "Bhutan",
                       "Bolivia (Plurinational State of)",
                       "Bonaire, Sint Eustatius and Saba",
                       "Bosnia and Herzegovina",
                       "Botswana",
                       "Bouvet Island",
                       "Brazil",
                       "British Indian Ocean Territory (the)",
                       "Brunei Darussalam",
                       "Bulgaria",
                       "Burkina Faso",
                       "Burundi",
                       "Cabo Verde",
                       "Cambodia",
                       "Cameroon",
                       "Canada",
                       "Cayman Islands (the)",
                       "Central African Republic (the)",
                       "Chad",
                       "Chile",
                       "China",
                       "Christmas Island",
                       "Cocos (Keeling) Islands (the)",
                       "Colombia",
                       "Comoros (the)",
                       "Congo (the Democratic Republic of the)",
                       "Congo (the)",
                       "Cook Islands (the)",
                       "Costa Rica",
                       "Croatia",
                       "Cuba",
                       "Curaçao",
                       "Cyprus",
                       "Czechia",
                       "Côte d'Ivoire",
                       "Denmark",
                       "Djibouti",
                       "Dominica",
                       "Dominican Republic (the)",
                       "Ecuador",
                       "Egypt",
                       "El Salvador",
                       "Equatorial Guinea",
                       "Eritrea",
                       "Estonia",
                       "Eswatini",
                       "Ethiopia",
                       "Falkland Islands (the) [Malvinas]",
                       "Faroe Islands (the)",
                       "Fiji",
                       "Finland",
                       "France",
                       "French Guiana",
                       "French Polynesia",
                       "French Southern Territories (the)",
                       "Gabon",
                       "Gambia (the)",
                       "Georgia",
                       "Germany",
                       "Ghana",
                       "Gibraltar",
                       "Greece",
                       "Greenland",
                       "Grenada",
                       "Guadeloupe",
                       "Guam",
                       "Guatemala",
                       "Guernsey",
                       "Guinea",
                       "Guinea-Bissau",
                       "Guyana",
                       "Haiti",
                       "Heard Island and McDonald Islands",
                       "Holy See (the)",
                       "Honduras",
                       "Hong Kong",
                       "Hungary",
                       "Iceland",
                       "India",
                       "Indonesia",
                       "Iran (Islamic Republic of)",
                       "Iraq",
                       "Ireland",
                       "Isle of Man",
                       "Israel",
                       "Italy",
                       "Jamaica",
                       "Japan",
                       "Jersey",
                       "Jordan",
                       "Kazakhstan",
                       "Kenya",
                       "Kiribati",
                       "Korea (the Democratic People's Republic of)",
                       "Korea (the Republic of)",
                       "Kuwait",
                       "Kyrgyzstan",
                       "Lao People's Democratic Republic (the)",
                       "Latvia",
                       "Lebanon",
                       "Lesotho",
                       "Liberia",
                       "Libya",
                       "Liechtenstein",
                       "Lithuania",
                       "Luxembourg",
                       "Macao",
                       "Madagascar",
                       "Malawi",
                       "Malaysia",
                       "Maldives",
                       "Mali",
                       "Malta",
                       "Marshall Islands (the)",
                       "Martinique",
                       "Mauritania",
                       "Mauritius",
                       "Mayotte",
                       "Mexico",
                       "Micronesia (Federated States of)",
                       "Moldova (the Republic of)",
                       "Monaco",
                       "Mongolia",
                       "Montenegro",
                       "Montserrat",
                       "Morocco",
                       "Mozambique",
                       "Myanmar",
                       "Namibia",
                       "Nauru",
                       "Nepal",
                       "Netherlands (the)",
                       "New Caledonia",
                       "New Zealand",
                       "Nicaragua",
                       "Niger (the)",
                       "Nigeria",
                       "Niue",
                       "Norfolk Island",
                       "Northern Mariana Islands (the)",
                       "Norway",
                       "Oman",
                       "Pakistan",
                       "Palau",
                       "Palestine, State of",
                       "Panama",
                       "Papua New Guinea",
                       "Paraguay",
                       "Peru",
                       "Philippines (the)",
                       "Pitcairn",
                       "Poland",
                       "Portugal",
                       "Puerto Rico",
                       "Qatar",
                       "Republic of North Macedonia",
                       "Romania",
                       "Russian Federation (the)",
                       "Rwanda",
                       "Réunion",
                       "Saint Barthélemy",
                       "Saint Helena, Ascension and Tristan da Cunha",
                       "Saint Kitts and Nevis",
                       "Saint Lucia",
                       "Saint Martin (French part)",
                       "Saint Pierre and Miquelon",
                       "Saint Vincent and the Grenadines",
                       "Samoa",
                       "San Marino",
                       "Sao Tome and Principe",
                       "Saudi Arabia",
                       "Senegal",
                       "Serbia",
                       "Seychelles",
                       "Sierra Leone",
                       "Singapore",
                       "Sint Maarten (Dutch part)",
                       "Slovakia",
                       "Slovenia",
                       "Solomon Islands",
                       "Somalia",
                       "South Africa",
                       "South Georgia and the South Sandwich Islands",
                       "South Sudan",
                       "Spain",
                       "Sri Lanka",
                       "Sudan (the)",
                       "Suriname",
                       "Svalbard and Jan Mayen",
                       "Sweden",
                       "Switzerland",
                       "Syrian Arab Republic",
                       "Taiwan",
                       "Tajikistan",
                       "Tanzania, United Republic of",
                       "Thailand",
                       "Timor-Leste",
                       "Togo",
                       "Tokelau",
                       "Tonga",
                       "Trinidad and Tobago",
                       "Tunisia",
                       "Turkey",
                       "Turkmenistan",
                       "Turks and Caicos Islands (the)",
                       "Tuvalu",
                       "Uganda",
                       "Ukraine",
                       "United Arab Emirates (the)",
                       "United Kingdom of Great Britain and Northern Ireland (the)",
                       "United States Minor Outlying Islands (the)",
                       "United States of America (the)",
                       "Uruguay",
                       "Uzbekistan",
                       "Vanuatu",
                       "Venezuela (Bolivarian Republic of)",
                       "Viet Nam",
                       "Virgin Islands (British)",
                       "Virgin Islands (U.S.)",
                       "Wallis and Futuna",
                       "Western Sahara",
                       "Yemen",
                       "Zambia",
                       "Zimbabwe",
                       "Åland Islands"]
    
//   var userInfo:[User] = []
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        
//      userInfo = DBManager.getAllUsers()
//      if !userInfo.isEmpty {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//            self.navigationController?.pushViewController(vc, animated: true)
//      }
        
        countrySelect.inputView = pickerView
        pickerView.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self
        countrySelect.delegate = self
        pickerView.layer.cornerRadius = 10
    }

    @IBAction func signUp(sender: UIButton){
        let username = userName.text
        let Password = password.text
        let emailid = emailId.text
        let countryselect = countrySelect.text
            if !emailid!.isEmpty  || !username!.isEmpty || !Password!.isEmpty || !countryselect!.isEmpty {
                if !username!.isValidUserName() {
                    let alert = UIAlertController(title:"Alert" , message:"Please Enter Valid User Name (username contain only characters)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                    present(alert, animated: true , completion: {
                        return
                    })
                }

                else if !emailid!.isValidEmail(){
                    let alert = UIAlertController(title:"Alert" , message:"Please Enter Valid EmailAdress", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                    present(alert, animated: true , completion: {
                        return
                    })
                }

                else if !Password!.isValidPassword() {
                    let alert = UIAlertController(title:"Alert" , message:"Please Enter Valid password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                    present(alert, animated: true , completion: {
                        return
                    })
                }
                else{
                    DBManager.createUser(country: countrySelect.text!, emailid: emailId.text!, name: userName.text!, password: password.text!) {
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
            else{
                let alert = UIAlertController(title:"Alert" , message:"Do Not Empty Any Fields", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return
                })
        }
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countrySelect.text = countryList[row]
        pickerView.isHidden = true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           pickerView.isHidden = false
           return false
       }
}
