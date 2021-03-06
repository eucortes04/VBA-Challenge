Attribute VB_Name = "Module1"
Sub StockAnalyzer()

'Variables
Dim YearlyDataRow As Integer
Dim YearlyOpenPrice As Double
Dim YearlyClosePrice As Double
Dim YearlyChange As Double
Dim YearlyPercentChange As Double
Dim TotalVolume As LongLong
Dim GreatestIncrease As Double
Dim GreatestIncreaseTicker As String
Dim GreatestDecrease As Double
Dim GreatestDecreaseTicker As String
Dim GreatestVolume As LongLong
Dim GreatestVolumeTicker As String
Dim LastRow As Long

YearlyDataRow = 2
LastRow = Range("A1").End(xlDown).Row
YearlyOpenPrice = Cells(2, 3).Value

'Filling in Titles  for easy delete and retest
Range("I1") = "Ticker"
Range("J1") = "Yearly Change"
Range("K1") = "Percentage Change"
Range("L1") = "Total Stock Volume"
Range("N2") = "Greatest % Increase"
Range("N3") = "Greatest % Decrease"
Range("N4") = "Greatest Total Volume"
Range("O1") = "Ticker"
Range("P1") = "Value"

'Loop Through Rows
For i = 2 To LastRow

    'Add Volume to Total Volume
    TotalVolume = TotalVolume + Cells(i, 7).Value
    
    'Has the Stock Changed
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
        'Share Ticker Symbol
        Cells(YearlyDataRow, 9).Value = Cells(i, 1).Value
    
        'Grab Year Close Price
        YearlyClosePrice = Cells(i, 6).Value
        
        'Calculate and Share Change and Percent
        YearlyChange = YearlyClosePrice - YearlyOpenPrice
            'Accounting for 0 Starting price, defaulting to .01 to still provide a Semi-accurate Change %
        If YearlyOpenPrice = 0 Then
            YearlyOpenPrice = 0.01
        End If
            
        YearlyPercentChange = YearlyChange / YearlyOpenPrice
        
        Cells(YearlyDataRow, 10).Value = YearlyChange
        Cells(YearlyDataRow, 11).Value = Format(YearlyPercentChange, "0.00%")
        
        'Formatting Yearly Change Cell
        If YearlyChange > 0 Then
            Cells(YearlyDataRow, 10).Interior.ColorIndex = 50
        ElseIf YearlyChange < 0 Then
            Cells(YearlyDataRow, 10).Interior.ColorIndex = 9
        Else
            Cells(YearlyDataRow, 10).Interior.ColorIndex = 27
        End If
            
        'Share Total Volume
        Cells(YearlyDataRow, 12).Value = TotalVolume
    
        'Is it Greatest Increase, if so store
        If YearlyPercentChange > GreatestIncrease Then
            GreatestIncrease = YearlyPercentChange
            GreatestIncreaseTicker = Cells(i, 1).Value
        End If
    
        'Is it Greatest Decrease, if so store
        If YearlyPercentChange < GreatestDecrease Then
            GreatestDecrease = YearlyPercentChange
            GreatestDecreaseTicker = Cells(i, 1).Value
        End If
            
        'Is it Greatest Volume, if so Store
        If TotalVolume > GreatestVolume Then
            GreatestVolume = TotalVolume
            GreatestVolumeTicker = Cells(i, 1).Value
        End If
        
     'Reset Open Price and Total Volume for next Stock/ add to Yearly data row
    YearlyOpenPrice = Cells(i + 1, 3).Value
    TotalVolume = 0
    YearlyDataRow = YearlyDataRow + 1
    
    End If
Next i

'Share Greatest Values 15 column
Cells(2, 15).Value = GreatestIncreaseTicker
Cells(2, 16).Value = Format(GreatestIncrease, "0.00%")
Cells(3, 15).Value = GreatestDecreaseTicker
Cells(3, 16).Value = Format(GreatestDecrease, "0.00%")
Cells(4, 15).Value = GreatestVolumeTicker
Cells(4, 16).Value = GreatestVolume


End Sub

