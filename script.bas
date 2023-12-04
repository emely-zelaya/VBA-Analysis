
    Sub stock_analysis()

'setting our variables
Dim i As Long
Dim column As Integer
Dim last_row As Long
Dim summary_row As Integer
Dim ticker_name As String
Dim total_vol As Double
Dim opening_price As Double
Dim closing_price As Double
Dim yearly_change As Double
Dim percent_change As Double

Dim maxIncreaseValue As Double
maxIncreaseValue = 0
  
Dim maxDecreaseValue As Double
maxDecreaseValue = 0

Dim maxVolumeValue As Double
maxVolumeValue = 0

 
Dim ws As Worksheet
For Each ws In Worksheets

'Headers
ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Yearly Change"
ws.Cells(1, 11).Value = "Percent Change"
ws.Cells(1, 12).Value = "Total Stock Volume"
ws.Range("P1").Value = "Ticker"
ws.Range("Q1").Value = "Value"
ws.Range("O2").Value = "Greatest % Increased"
ws.Range("O3").Value = "Greatest % Decreased"
ws.Range("O4").Value = "Greatest Total Volume "

column = 1
last_row = ws.Cells(Rows.Count, 1).End(xlUp).Row
opening_price = ws.Cells(2, 3).Value

'initializing our counter
summary_row = 2
total_volume = 0

'Loop through rows in 1st column for whole worksheet
For i = 2 To last_row

total_vol = total_volume + ws.Cells(i, 7).Value

'Declare when one cell in column 1 is different from another
If ws.Cells(i + 1, column).Value <> ws.Cells(i, column).Value Then
   
   
   'set the ticker_name in column 9
   ticker_name = ws.Cells(i, column).Value
   ws.Cells(summary_row, 9).Value = ticker_name
   
   

   'Calculating yearly change & percent_change

   closing_price = ws.Cells(i, 6).Value
   yearly_change = closing_price - opening_price
   
   'Set yearly change in column 10 based on summary row
   ws.Cells(summary_row, 10).Value = yearly_change
   
   If (opening_price > 0) Then
    percent_change = (yearly_change / opening_price) * (100)
   Else
   percent_change = 0
   
   End If
   

   'Set percent change in column 11 based on summary row
   ws.Cells(summary_row, 11).Value = percent_change

   'set the total_vol in column 12
   ws.Cells(summary_row, 12).Value = total_vol
   
   'Conditionally format yearly_change column using colors based on whether positive or negative
   
   
   If yearly_change > 0 Then
   ws.Cells(summary_row, 10).Interior.ColorIndex = 4
   Else
   ws.Cells(summary_row, 10).Interior.ColorIndex = 3
   
   End If
   
   
   

opening_price = ws.Cells(i + 1, 3).Value
total_volume = 0
summary_row = summary_row + 1

End If

Next i

last_row = ws.Cells(Rows.Count, 11).End(xlUp).Row
    
    ' Loop through each row to calculate values
    For i = 2 To last_row ' Assuming row 1 contains headers
        
        ' Check for greatest % Increase
        If ws.Range("K" & i).Value > ws.Range("Q2").Value Then
                    ws.Range("Q2").Value = ws.Range("K" & i).Value
                    ws.Range("P2").Value = ws.Range("I" & i).Value
                End If
        
        ' Check for greatest % Decrease
        If ws.Range("K" & i).Value < ws.Range("Q3").Value Then
                    ws.Range("Q3").Value = ws.Range("K" & i).Value
                    ws.Range("P3").Value = ws.Range("I" & i).Value
        End If
        
        ' Check for greatest Total Volume
        If ws.Range("L" & i).Value > ws.Range("Q4").Value Then
                    ws.Range("Q4").Value = ws.Range("L" & i).Value
                    ws.Range("P4").Value = ws.Range("I" & i).Value
        End If
    Next i
    
    ' Format Double To Include % Symbol And Two Decimal Places
            ws.Range("Q2").NumberFormat = "0.00%"
            ws.Range("Q3").NumberFormat = "0.00%"
            

Next ws

End Sub