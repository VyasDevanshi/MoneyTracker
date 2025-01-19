//
//  AnalysisViewController.swift
//  MoneyTracker
//
//  Created by Mac on 18/12/1944 Saka.
//

import UIKit
import Charts

class AnalysisViewController: UIViewController,ChartViewDelegate {

    @IBOutlet weak var piChartView: PieChartView!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var monthPickerView: UIPickerView!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var monthTextField: UITextField!
 
    @IBOutlet weak var segmentAnalyse: UISegmentedControl!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var transactions:[Transaction] = []
     
    var startDate = Date()
    var endDate = Date()
    var sumOfExpense:Double = 0
    var sumOfIncome:Double = 0
    var sumOfIncomes:Double = 0
    var selectedOption: String?
    var sortList:[String] = ["Weekly",
                              "Monthly",
                              "Yearly"]
    
    var incomeTyeAmount: [Double] = []
    var expenseTypeAmount: [Double] = []
    var dataOnXAxis: [Double] = []
    var dataOnYAxis: [Double] = []
    
    var dataMainArray:[DashBoardData] = []
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var selectedDate = Date()
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor: UIColor.white]
        dataShow()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        monthPickerView.isHidden = true
        monthPickerView.dataSource = self
        monthPickerView.delegate = self
        piChartView.delegate = self
       
        barChartView.delegate = self
        monthTextField.inputView = monthPickerView
        monthTextField.delegate = self
        dateTextField.delegate = self
      
        barChartView.isHidden = true
        
        dateTextField.borderStyle = .none
        monthTextField.borderStyle = .none
        
        monthPickerView.layer.cornerRadius = 10
        segmentAnalyse.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], for: UIControl.State.selected)
        segmentAnalyse.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        showDate()
    }
    
    func dataShow() {
        setLayout()
        if segmentAnalyse.selectedSegmentIndex == 0{
            print(selectedDate)
            if selectedOption == "Weekly" {
                startDate = selectedDate.startOfWeek!
                endDate = selectedDate.endOfWeek!
            } else if selectedOption == "Monthly" {
                startDate = selectedDate.startDateOfMonth!
                endDate = selectedDate.endDateOfMonth!
            } else if selectedOption == "Yearly" {
                startDate = selectedDate.startDateOfYear!
                endDate = selectedDate.enddateOfYear!
            }
            else{
                startDate = selectedDate.startOfWeek!
                endDate = selectedDate.endOfWeek!
            }
        }
        
        else if segmentAnalyse.selectedSegmentIndex == 1{
            
            print(selectedDate)
            if selectedOption == "Weekly" {
                startDate = selectedDate.startOfWeek!
                endDate = selectedDate.endOfWeek!
            } else if selectedOption == "Monthly" {
                startDate = selectedDate.startDateOfMonth!
                endDate = selectedDate.endDateOfMonth!
               
            } else if selectedOption == "Yearly" {
                startDate = selectedDate.startDateOfYear!
                endDate = selectedDate.enddateOfYear!
            }
            else{
                startDate = selectedDate.startOfWeek!
                endDate = selectedDate.endOfWeek!
            }
            
        }
        
            transactions = DBManager.filterTransactions(startDate: startDate, endDate: endDate)
            transactions.sort(by: { $0.date! < $1.date! })
        
        if segmentAnalyse.selectedSegmentIndex == 0{
            for t in transactions{
                if t.type {
                    incomeTyeAmount.append(t.amount)
                }
                else{
                    expenseTypeAmount.append(t.amount)
                    // expenseCategoryName.append(t.category!)
                }
            }
            
            for ic in incomeTyeAmount {
                sumOfIncome += ic
            }
            
            for ec in expenseTypeAmount{
                sumOfExpense += ec
            }
            
            showPieChart()
        }
        
        else if segmentAnalyse.selectedSegmentIndex == 1 {
            let df2 = DateFormatter()
            if selectedOption == "Weekly"{
                df2.dateFormat = "dd/MM/YYYY"
            }
            else if selectedOption == "Monthly"{
                df2.dateFormat = "W'\u{02DA}Week"
            }
            else if selectedOption == "Yearly"{
                df2.dateFormat = "MMM"
            }
            else{
                df2.dateFormat = "dd/MM/YYYY"
            }
            
            for t in transactions {
                
                var isFound = false
                for j in dataMainArray {
                    
                    if df2.string(from: j.date!) == df2.string(from: t.date!) {
                        
                        j.arrayItem.append(t)
                        
                        if t.type{
                            
                            j.incomeAmounts += t.amount
                            
                            
                        }else {
                            
                            j.expenseAmount += t.amount
                            
                        }
                        isFound = true
                    }
                }
                
                if  !isFound {
                    let newobj = DashBoardData()
                    newobj.date = t.date
                    newobj.arrayItem.append(t)
                    if t.type {
                        newobj.incomeAmounts = t.amount
                    }else{
                        newobj.expenseAmount = t.amount
                    }
                    dataMainArray.append(newobj)
                }
            }
            showBarChart()
        }
    }
    
    func setLayout(){
        incomeTyeAmount.removeAll()
        expenseTypeAmount.removeAll()
        dataMainArray.removeAll()
        sumOfIncome = 0
        sumOfExpense = 0
    }
    
    func showPieChart(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        formatter.percentSymbol = "%"
        // if segmentAnalyse.selectedSegmentIndex == 0 {
        
        piChartView.usePercentValuesEnabled = true
        piChartView.legend.enabled = true
        // piChartView.drawEntryLabelsEnabled = true
        let l = piChartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        piChartView.drawHoleEnabled = false
        piChartView.chartDescription.enabled = true
        piChartView.entryLabelColor = .white
        piChartView.legend.enabled = true
        
        var totalValue = sumOfIncome + sumOfExpense
        totalValue = totalValue > 0 ? totalValue : 1
        var incomePer = ((sumOfIncome * 100) / totalValue)
        var expPer = ((sumOfExpense * 100) / totalValue)
        var entries = [ChartDataEntry]()
        entries.append(PieChartDataEntry(value: sumOfIncome , label: "Income"))
        entries.append(PieChartDataEntry(value: sumOfExpense , label: "Expense"))
        
        // Create data set
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
//      Set colors for the sections of the pie chart
//      dataSet.colors  = ChartColorTemplates.pastel()
        
      //  dataSet.colors = [UIColor.gray,UIColor.systemBlue]
        let c1 = UIColor(red: 40/255, green: 181/255, blue: 200/255, alpha: 1)
        let c2 = UIColor(red: 229/255, green: 0, blue: 0, alpha: 1)
        dataSet.colors = [c1,c2]
        
        // Create chart data
        let chartData = PieChartData(dataSet: dataSet)
        piChartView.data = chartData
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
    }
    
    func showBarChart() {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = " %"
        formatter.maximumFractionDigits = 2
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12)
        barChartView.xAxis.drawGridLinesEnabled = false
        
        barChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12)
        barChartView.rightAxis.enabled = false
    
        
        if selectedOption == "Weekly"{
            barChartView.xAxis.valueFormatter = DateValueFormatter2(objects: dataMainArray)
        }
        
        else if selectedOption == "Monthly"{
            barChartView.xAxis.valueFormatter = DateValueFormatter3(objects: dataMainArray)
        }
        
        else if selectedOption == "Yearly"{
            barChartView.xAxis.valueFormatter = DateValueFormatter4(objects: dataMainArray)
        }
        
        else{
            barChartView.xAxis.valueFormatter = DateValueFormatter2(objects: dataMainArray)
        }
        
        barChartView.legend.font = UIFont.systemFont(ofSize: 12)
        barChartView.legend.enabled = true
        barChartView.legend.horizontalAlignment = .right
        barChartView.legend.verticalAlignment = .top
        barChartView.legend.orientation = .horizontal
        barChartView.legend.drawInside = false
        barChartView.chartDescription.enabled = true
        
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        barChartView.drawValueAboveBarEnabled = true
        
        var incomeEntries = [BarChartDataEntry]()
        var expenseEntries = [BarChartDataEntry]()
        dataMainArray.sort(by: { $0.date! < $1.date! })

        for (i,trData) in dataMainArray.enumerated() {
            incomeEntries.append(BarChartDataEntry(x: Double(i), y:Double(trData.incomeAmounts)))
            expenseEntries.append(BarChartDataEntry(x: Double(i), y:Double(trData.expenseAmount)))
        }

        let chartDataSetIncome = BarChartDataSet(entries: incomeEntries, label: "Income")
        chartDataSetIncome.colors = [UIColor(red: 40/255, green: 181/255, blue: 200/255, alpha: 1)]

        let chartDataSetExpense = BarChartDataSet(entries: expenseEntries , label: "Expense")
        chartDataSetExpense.colors = [UIColor(red:  229/255, green: 0, blue: 0, alpha: 1)]
        
        let chartData2 = BarChartData(dataSets: [chartDataSetIncome,chartDataSetExpense])
        
        barChartView.data = chartData2
        let groupSpace = 0.3
        let barSpace = 0.0
        let barWidth = 0.2
        
//      restrict the x-axis range
//        barChartView.xAxis.axisMinimum = 0

//      groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        barChartView.xAxis.axisMaximum =  chartData2.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(expenseEntries.count)

        chartData2.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
//        barChartView.xAxis.centerAxisLabelsEnabled = true

//      chartData2.barWidth = barWidth
//      let xAxis = barChartView.xAxis

        barChartView.xAxis.granularity = 1

//      let xAxis = barChartView.xAxis
//      barChartView.xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
     // xAxis.valueFormatter = IntAxisValueFormatter()

    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        dateTextField.text = dateFormatter.string(from: selectedDate)
        dataShow()
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        dateTextField.text = dateFormatter.string(from: selectedDate)
    }
    
    @IBAction func changeAnalysisSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            piChartView.isHidden = false
            barChartView.isHidden = true
        }
        
        else if sender.selectedSegmentIndex == 1{
            barChartView.isHidden = false
            piChartView.isHidden = true
        }
        
        dataShow()
    }
    
    func showDate() {
        
        datePicker.datePickerMode = .dateAndTime
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        //segmentHome.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        let initialDate = Date()
        datePicker.date = initialDate
        
        //Set date picker as input view for text field
        dateTextField.inputView = datePicker
        
        // Add a toolbar with a Done button to dismiss the date picker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
        }
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.items = [doneButton]
        dateTextField.inputAccessoryView = toolbar
        dateTextField.text = dateFormatter.string(from: selectedDate)
        print(selectedDate)
    }
    
}

extension AnalysisViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortList.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortList[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = sortList[row]
        monthTextField.text = selectedOption
        monthPickerView.isHidden = true
        viewHeight.constant = 30
        
        if segmentAnalyse.selectedSegmentIndex == 0{
            if selectedOption == "Weekly"{
                dateFormatter.dateFormat = "dd/MM/YYYY"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
                
            }
            
            else if selectedOption == "Monthly"{
                dateFormatter.dateFormat = "MMMM"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
                
            }
            
            else if selectedOption == "Yearly"{
                dateFormatter.dateFormat = "YYYY"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
                
            }
            
            else{
                dateFormatter.dateFormat = "dd/MM/YYYY"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
            }
        }
        
        else if segmentAnalyse.selectedSegmentIndex == 1{
            
            if selectedOption == "Weekly"{
                dateFormatter.dateFormat = "dd/MM/YYYY"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
            }
            else if selectedOption == "Monthly"{
                dateFormatter.dateFormat = "MMMM"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
                
            }
            else if selectedOption == "Yearly"{
                dateFormatter.dateFormat = "YYYY"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
            }
            else{
                dateFormatter.dateFormat = "dd/MM/YYYY"
                selectedDate = datePicker.date
                dateTextField.text = dateFormatter.string(from: selectedDate)
            }
        }
        dataShow()

    }
        
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == monthTextField{
        viewHeight.constant = 150
            monthPickerView.isHidden = false
           return false
     }
        return true
    }
    
}


public class DateValueFormatter2: NSObject, AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    private let objects:[DashBoardData]
    
    init(objects: [DashBoardData]) {
        self.objects = objects
        super.init()
        dateFormatter.dateFormat = "EEE"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value >= 0 && Int(value) < objects.count{
            let object = objects[Int(value)]
            return dateFormatter.string(from: object.date!)
        }
        return ""
    }
}

public class DateValueFormatter3: NSObject, AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    private let objects:[DashBoardData]
    
    init(objects: [DashBoardData]) {
        self.objects = objects
        super.init()
            dateFormatter.dateFormat = "W'\u{02DA}Week"
    }
    
public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value >= 0 && Int(value) < objects.count{
            let object = objects[Int(value)]
            return dateFormatter.string(from: object.date!)
        }
        return ""
    }
}

public class DateValueFormatter4: NSObject, AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    private let objects:[DashBoardData]
    init(objects: [DashBoardData]) {
        self.objects = objects
        super.init()
        dateFormatter.dateFormat = "MMM"
}
    
public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value >= 0 && Int(value) < objects.count {
            let object = objects[Int(value)]
            return dateFormatter.string(from: object.date!)
        }
        return ""
    }
}
