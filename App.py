#4 importerar flask
#4importerar sqlite3
from flask import Flask, render_template
import sqlite3

app = Flask(__name__)

@app.route("/")
def home():                                                                                                                                                  
 
 #15 ansluter sqlite3 till databasen
 #16 gör så att man läsa databasen
 #17 läser kustannus_Id, kustannus_name och så avrundar det euro_brutto så att den har en decimal och så delar det talet med 1000000. sen tar den de 5 högsta talen från kustannus_id och euro brutto.
 #18 kör rad 15-17
    con = sqlite3.connect("Yrkesprov1.db")
    cur = con.cursor()
    cur.execute('SELECT kustannus_id, kustannus_name, ROUND(sum(euro_brutto)/1000000, 1) FROM porvoo GROUP BY kustannus_id ORDER BY sum(euro_brutto) DESC LIMIT 5;')
    data = cur.fetchall()
#20 stänger rad 15-18
    con.close()
   
     
  #27 ansluter till databasen
  #28 gör så att man kan läsa databasen
  #29 tar Hex värdena från tabellen colors
  #30 kör rad 27-30
    con = sqlite3.connect("Yrkesprov1.db")
    cur = con.cursor()
    cur.execute('SELECT HEX FROM colors;')
    rows = cur.fetchall()
#32 stänger rad 27-30
    con.close()

    
#36-38 säger att de är listor
    values = []
    labels = []
    colors = []
   
    
    
#44-45 lopar igenom varje rad som man har deklarerat. det loopar igenom listorna    
    for row in data:
         values.append(row[2])
         labels.append(row[1])
#48 går igenom raderna i listan och lägger till en hashtag så att det blir hex värden.
    for row in rows:
         colors.append("#" + row[0])
         
         

          
#54 skickar labels som labels, values som values och colors som colrs till graph.html så att htmlen ska få ut värdena.
return render_template("graph.html", labels=labels, values=values, colors=colors)


if __name__ == "__main__":
#59 lägger på htlmen på port 800 och så lägger den på debuggen
    app.run(port=8000, debug=True)
    

