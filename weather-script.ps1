#Api Key 
$ApiKey = "1ecf6820062f48d881b03109222903"

#Taking input of the location and the number of days

$Location = Read-Host -Prompt "Input the location"
$Days = Read-Host -Prompt "Input the number of days (max: 3 days)"

#The dynamic URL to fetch the data from weather API.
$Url = "http://api.weatherapi.com/v1/forecast.json?key=$ApiKey&q=$Location&Days=$Days"

#Checking the URL if it is working.
Write-Host "$Url"


Write-Host "Updated weather information -"

#Using try-catch block to avoid bad request

try { $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing }
catch { "An error occurred." }

#Converting the data from JSON format

$ConvertedJsonData = $Request.Content | ConvertFrom-Json

$Forecast = $ConvertedJsonData.forecast.forecastday

#This condition checks if the inputs are true

if($Days -AND $Location){
ForEach($Day in $Forecast){
$Date = $Day.date
$HighTemp = $Day.day.maxtemp_c
$LowTemp = $Day.day.mintemp_c
$Condition = $Day.day.condition.text
$MaxWindKph = $Day.day.maxwind_kph
$Humidity = $Day.day.avghumidity

#Showing the forecast
Write-Host "The weather forecast for date: $Date in $Location"
Write-Host "The condition of the weather is $Condition .
It will have a high temperature of $HighTemp C and a low temperature of $LowTemp C.
The max wind will be $MaxWindKph Kph.
The hunidity will be $Humidity.
--------------------------------"
}} else { Write-Host "To get the weather information you have to put the location and number of days" }

Write-Host "Thank you" 