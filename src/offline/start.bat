$echo off
powershell set-executionpolicy remotesigned
powershell .\removal_offline.ps1
powershell set-executionpolicy restricted