# NASAapi
Query a NASA API in 5 languages.

JSON data is retrieved from the 'Asteroids - NeoWs' section of api.nasa.gov, then
parsed into a flat, custom structure.  Some averaging and rounding takes place.
Examples of Raw (not processed) JSON returned from the NASA API is in the JSON folder.

Completed:  PowerShell, Python, Node.js & Ruby
Some Day:  Go

All Versions were written to run via PowerShell 7, however other
shells can be used with little or no modification.

Usage:

1.  Create an API key here: https://api.nasa.gov/ ; the process is easy and free.
2.  Make the API Key available by either a or b below:
    a.  Simple / (mostly) Secure:
        Export NASA_API_KEY='Your_Key_Goes_Here' in your shell.
        In PowerShell, at the user level:
        [System.Environment]::SetEnvironmentVariable('NASA_API_KEY','Your_Key_Goes_Here',[System.EnvironmentVariableTarget]::User)
        Other shells can use the export command to accomplish the same result.
    b.  Less Simple / Secure:
        Comment out the key from environment line, and decomment the hard-coded line.
        In get_Nasa.js, this changes lines 32 and 33 to look as follows:
        32  //let key = process.env.NASA_API_KEY ;
        33  let key = 'Your_Key_Goes_Here' ;
        Changes are similar in other languages.
3.  For PowerShell just run it.  It should function correctly in PowerShell 5 or 7.
    For Python, install into your main or virtual env the modules in requirements.txt.
    For Node.js install into your directory the modules listed in package.json.
    For Ruby, install the modules within the Gemfile.
4.  From PowerShell 7.0.2, returning the JSON data into a PSCustomObject:
    C:\NASAapi> $ps = .\PowerShell\GetNasa.ps1
    C:\NASAapi> $py = python.exe .\Python\getNasa.py | ConvertFrom-Json -Depth 4
    C:\NASAapi> $nj = node.exe .\Node.js\getNasa.js | ConvertFrom-Json -Depth 4
    C:\NASAapi> $rb = ruby.exe .\Python\getNasa.py | ConvertFrom-Json -Depth 4
5.  Note that running the Python, Node.Js and Ruby scripts without ConvertFrom-JSON
    results in 'plain' JSON.
6.  Conversely, to obtain plain JSON from PowerShell, execute
    .\PowerShell\GetNasa.ps1 | ConvertTo-Json -Depth 4

