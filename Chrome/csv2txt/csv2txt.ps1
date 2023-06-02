# Import the CSV file
$data = Import-Csv -Path '.\Scripts\csv2txt\top500Domains.csv'
$data.'Root Domain' | Out-File '.\Scripts\csv2txt\urls.txt'