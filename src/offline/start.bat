$echo off
powershell set-executionpolicy remotesigned
powershell .\Removal offline.ps1
powershell set-executionpolicy restricted