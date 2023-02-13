Webrequest = Invoke-WebRequest "https://www.avoindata.fi/data/dataset/d203038a-fa46-40b8-80b4-33479bf64412/resource/a71df935-054d-4e83-8e07-e2e15f6224ed/download/ostolaskudata-2021-porvoon-kaupunki.csv" -UseBasicParsing -OutFile "C:\temp\Räkningar.csv"

$Csv = Import-Csv -path home\kenny\Räkningar.csv -Delimiter ';' -Encoding utf7

$database ="C:\temp\Yrkesprov1.db"
$query = "CREATE TABLE PORVOO (INTEGER PRIMARY KEY,
kustannus_id INTEGER,
kustannus_name TEXT,
tosite_number INTEGER,
tositename TEXT,
euro_brutto REAL,
rondo_id INTEGER);"

Invoke-sqlitequery -query $query -Datasource $database

$tilldatabasen | ForEach-Object {

$query = "INSERT INTO Yrkesprov1
