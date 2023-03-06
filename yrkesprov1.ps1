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
     
     
     
     

     $database ="/home/kenny/Yrkesprov1.db"
     $query = "CREATE TABLE COLORS (INTEGER PRIMARY KEY,
     Red INTEGER,
     Green INTEGER,
     Blue INTEGER);"

     Invoke-sqlitequery -query $query -Datasource $database


     ForEach-Object {

     $query = "INSERT INTO COLORS (Red, Green, Blue) VALUES ('255', '99', '132'), ('54', '162', '235'), ('255', '205', '86'), ('25', '135', '69'), ('139', '100', '100');"
     Invoke-SqliteQuery -query $query -Datasource $database
     


     invoke-sqlitequery -query "select * from COLORS" -datasource $database
     }
