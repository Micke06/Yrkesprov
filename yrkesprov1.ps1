invoke-webrequest "https://www.avoindata.fi/data/dataset/d203038a-fa46-40b8-80b4-33479bf64412/resource/a71df935-054d-4e83-8e07-e2e15f6224ed/download/ostolaskudata-2021-porvoon-kaupunki.csv" -UseBasicParsing -OutFile "/home/kenny/Räkningar.csv"

$Csv = Import-Csv -path /home/kenny/Räkningar.csv -Delimiter ';' -Encoding utf7

$database ="/home/kenny/Yrkesprov1.db"
$query = "CREATE TABLE PORVOO (INTEGER PRIMARY KEY,
kustannus_id INTEGER,
kustannus_name TEXT,
tosite_number INTEGER,
tositename TEXT,
euro_brutto REAL,
rondo_id INTEGER);"

Invoke-sqlitequery -query $query -Datasource $database




$Csv | ForEach-Object {

                       $tosite_number = $_.Tositenumero

                       $Kustannus_id = $_.Kustannuspaikka

                       $Kustannus_name = $_.'Kustannuspaikan nimi'

                       $tositename = $_.Selite.Replace("'" ,"")

                       $euro_brutto = $_.'EUR, brutto'.replace(" " ,"")

                       $rondo_id = $_.'Rondo ID'
   
                     $query = "INSERT INTO PORVOO (tosite_number, kustannus_id, kustannus_name, tositename, euro_brutto, rondo_id) VALUES ('$tosite_number','$Kustannus_id','$Kustannus_name','$tositename','$euro_brutto','$rondo_id');"
                     Invoke-SqliteQuery -query $query -Datasource $database
                     }


     invoke-sqlitequery -query "select * from PORVOO" -datasource $database       
     
     
     
     

     
     
     $Query = "CREATE TABLE colors (id INTEGER PRIMARY KEY, 
     hex TEXT);"

Invoke-SqliteQuery -Query $Query -DataSource $Database



$query = "INSERT INTO colors (hex) 
VALUES 
('59c1a6'),('c32125'),('1b5f87'),('671495'),('38071e');"
Invoke-SqliteQuery -Query $Query -DataSource $Database


$colordb = Invoke-SqliteQuery -Query "select * from colors;" -DataSource $Database
