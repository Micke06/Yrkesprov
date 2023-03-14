#2 tar information från länken och lagar en mapp till /home/kenny i filerna
invoke-webrequest "https://www.avoindata.fi/data/dataset/d203038a-fa46-40b8-80b4-33479bf64412/resource/a71df935-054d-4e83-8e07-e2e15f6224ed/download/ostolaskudata-2021-porvoon-kaupunki.csv" -UseBasicParsing -OutFile "/home/kenny/Räkningar.csv"

#5lagar en variabel $csv, import-csv gör kolumner istället för kommatecken mellan varje ord,-delimeter ändrar kommatecknet till det som är inne i de enkla citattecknena och encoding utf7 gör så att åäö syns.
$Csv = Import-Csv -path /home/kenny/Räkningar.csv -Delimiter ';' -Encoding utf7

#15 $database lagar databasen och platsen vart den är och vad den heter
#16 $guery lagar en tabell som heter PORVOO och INTEGER PRIMARY KEY ger ett unikt värde (INTEGER som är ett heltal) åt varje kolumn i tabellen.
#17 lagar en kolumn som är ett heltal
#18 lagar en kolumn som är text
#19 lagar en kolumn som är ett heltal
#20 lagar en kolumn som är text
#21 lagar en kolumn som är decimaltal
#22 lagar en kolumn som är ett heltal
$database ="/home/kenny/Yrkesprov1.db"
$query = "CREATE TABLE PORVOO (INTEGER PRIMARY KEY,
kustannus_id INTEGER,
kustannus_name TEXT,
tosite_number INTEGER,
tositename TEXT,
euro_brutto REAL,
rondo_id INTEGER);"

#25 Skapar databasen som heter Yrkesprov1 och så skapar den också tabellen.
Invoke-sqlitequery -query $query -Datasource $database



#30 lagar en loop som går igenom varje object inom de här tecknena {} om och om igen 
$Csv | ForEach-Object {
#33 $tosite_number syns som tositenumero.  $_ refererar till ett specifikt objekt.
#40 $kustannus_id syns som kustannuspaikka
#42 $kustannus_name syns som kustannuspaikan nimi
#44 $tositename syns som selite och så replacea jag vissa tecken för att de inte ville visas när man körde scriptet. replacea ' med ingenting
#46 $euro brutto syns som EUR; brutto replacea mellanslag med ingenting
#48 $rondo_id syns som Rondo ID

                       $tosite_number = $_.Tositenumero

                       $Kustannus_id = $_.Kustannuspaikka

                       $Kustannus_name = $_.'Kustannuspaikan nimi'

                       $tositename = $_.Selite.Replace("'" ,"")

                       $euro_brutto = $_.'EUR, brutto'.replace(" " ,"")

                       $rondo_id = $_.'Rondo ID'
   
#51 lagar all information från tabellen till databsen
                     $query = "INSERT INTO PORVOO (tosite_number, kustannus_id, kustannus_name, tositename, euro_brutto, rondo_id) VALUES ('$tosite_number','$Kustannus_id','$Kustannus_name','$tositename','$euro_brutto','$rondo_id');"
#53 skapar databasen som har all information.              
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



jinja substituerar vad man har definierat i en parameter tar emot argument
