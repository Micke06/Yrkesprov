$webrequest = Invoke-WebRequest "https://www.avoindata.fi/data/dataset/d203038a-fa46-40b8-80b4-33479bf64412/resource/a71df935-054d-4e83-8e07-e2e15f6224ed/download/ostolaskudata-2021-porvoon-kaupunki.csv" -UseBasicParsing -OutFile "/home/kenny/Räkningar.csv"

$Csv = Import-Csv -path /home/kenny/Räkningar.csv -Delimiter ';' -Encoding utf8

$database ="/home/kenny/Yrkesprov1.db"
$query = "CREATE TABLE PORVOO (INTEGER PRIMARY KEY,
kustannus_id INTEGER,
kustannus_name TEXT,
tosite_number INTEGER,
tositename TEXT,
euro_brutto REAL,
rondo_id INTEGER);"

Invoke-sqlitequery -query $query -Datasource $database

$tilldatabasen | ForEach-Object {
                     $tosite_number = $_.Tositenumero
                     $Kustannus_id = $_.Kustannuspaikka
                     $Kustannus_name = $_.'Kustannuspaikan nimi'
                     $tositename = $_.Selite
                     $euro_brutto = $_.'EUR, brutto'
                     $rondo_id = $_.'Rondo ID'
                        
                     }




                     
$query = "INSERT INTO Yrkesprov1


