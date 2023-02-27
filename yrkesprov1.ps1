Remove-Item C:\temp\Yrkesprov1.db

$webrequest = Invoke-WebRequest "https://www.avoindata.fi/data/dataset/d203038a-fa46-40b8-80b4-33479bf64412/resource/a71df935-054d-4e83-8e07-e2e15f6224ed/download/ostolaskudata-2021-porvoon-kaupunki.csv" -UseBasicParsing -OutFile "C:\temp\Räkningar.csv"

$Csv = Import-Csv -path C:\temp\Räkningar.csv -Delimiter ';' -Encoding utf7

$database ="C:\temp\Yrkesprov1.db"
$query = "CREATE TABLE PORVOO (INTEGER PRIMARY KEY,
kustannus_id INTEGER,
kustannus_name TEXT,
tosite_number INTEGER,
tositename TEXT,
euro_brutto REAL,
rondo_id INTEGER);"

Invoke-sqlitequery -query $query -Datasource $database

$Counter = 0



$Csv | ForEach-Object {
$Counter = $Counter + 1
$Counter
                     $tosite_number = $_.Tositenumero

                     $Kustannus_id = $_.Kustannuspaikka

                     $Kustannus_name = $_.'Kustannuspaikan nimi'

                     $tositename = $_.Selite.Replace("'" ,"")

                     $euro_brutto = $_.'EUR, brutto'.replace(" " ,"")

                     $rondo_id = $_.'Rondo ID'

   
                     $query = "INSERT INTO PORVOO (tosite_number, kustannus_id, kustannus_name, tositename, euro_brutto, rondo_id) VALUES ('$tosite_number','$Kustannus_id','$Kustannus_name','$tositename','$euro_brutto','$rondo_id');"
                     Invoke-SqliteQuery -query $query -Datasource $database
                     }
                     
                     
                     
                     
                      sudo apt install /home/kenny/Downloads/code_1.75.1-1675893397_amd64.deb

