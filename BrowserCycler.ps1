# Cycle through web pages on and off

# List of pages to go through:
$pages = @(
'https://www.cbsnews.com/',
'https://www.theguardian.com/us',
'https://www.aol.com/news/?icid=aol.com-nav',
'https://www.msn.com/en-us/news',
'https://www.msnbc.com/',
'https://finance.yahoo.com/',
'https://www.foxnews.com/',
'https://www.cnn.com/',
'https://drudgereport.com/'
)

# Shuffles array on each script run:
function randomize
{
   Param(
     [array]$inputArray
   )

   return $inputArray | Get-Random -Count $inputArray.Count;
}


# Close Brave browser if open:
If ((get-process).Name -contains 'Brave'){Stop-Process -Name Brave -Force | out-null}
# Close Chrome browser if open:
#If ((get-process).Name -contains 'Chrome'){Stop-Process -Name Brave -Force | out-null}

# Loop through pages X number of times:
$x = 100

For($i=0; $i -lt $x; $i++){

    $randomized = (randomize -inputArray $pages).replace(" ", ",")

    If ((get-process).Name -notcontains 'Brave'){

        # Cycle through each page in array
        Foreach ($page in $randomized) {

        # Using Brave web browser:
        start "C:\Program Files (x86)\BraveSoftware\Brave-Browser\Application\brave.exe" $page
        # Using Chrome:
        #start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe $page"
        # You don't want all the pages loading at once, so make it delay a bit
        start-sleep 5

        }

    Do {

            # Close each current active page
            $wshell = New-Object -ComObject wscript.shell
            # Switch to Chrome
            if($wshell.AppActivate('Brave')) { 
            # Wait for Chrome to "activate"
            Sleep 1 
            # Refresh current page; not used here
            #$wshell.SendKeys('{F5}')  # Send F5 (Refresh)
            $wshell.SendKeys("^w")}
        
        }

        Until ((get-process).Name -notcontains 'Brave')

    }

}







