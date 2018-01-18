*** Settings ***
Library           Process

*** Test Cases ***
Connect VCloud Server
    Run Process    C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe
