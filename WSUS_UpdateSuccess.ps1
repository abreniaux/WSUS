# find all lines with "successfully installed":
Select-String -Path $env:windir\WindowsUpdate.log -Pattern 'successfully installed' |
  ForEach-Object {
    $information = $_ | Select-Object -Property Date, LineNumber, Product 
    # take line and split it at tabulators
    $parts = $_.Line -split '\t'

    # create Date and Time
    # first tab-separated part contains date
    # second tab-separated part contains time,
    # take only first 8 characters and omit milliseconds
    [DateTime]$information.Date = $parts[0] + ' ' + $parts[1].SubString(0,8) 
    # extract product name which always follows after 'following update: ':
    $information.Product = ($_.Line -split 'following update: ')[-1]
    # return custom object
    $information
  } | Out-GridView 
