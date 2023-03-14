from flask import Flask, render_template
import sqlite3

app = Flask(__name__)

@app.route("/")
def home():                                                                                                                                                  
 
    con = sqlite3.connect("Yrkesprov1.db")
    cur = con.cursor()
 
    cur.execute('SELECT kustannus_id, kustannus_name, ROUND(sum(euro_brutto)/1000000, 1) FROM porvoo GROUP BY kustannus_id ORDER BY sum(euro_brutto) DESC LIMIT 5;')
    data = cur.fetchall()

    con.close()
   # data = [
        #("01-01-2020", 1597),
        #("01-02-2020", 1456),
       # ("01-03-2020", 1908),
       # ("01-04-2020", 896),
      #  ("01-05-2020", 755),

      #  ("01-06-2020", 355),
      #  ("01-07-2020", 155),
      #  ("01-08-2020", 145),
      #  ("01-09-2020", 725),
   # ]
    #colors = ['rgb(255, 99, 132)','rgb(54, 162, 235)','rgb(255, 205, 86)','rgb(25, 135, 69)', 'rgb(139, 100, 100)','rgb(10, 255, 20)', 'rgb(255,255, 86)','rgb(255, 178, 90)','rgb(155, 150, 69)']
    #with open ('Yrkesprov1.db', encoding="latin1") as f:
     
    
    con = sqlite3.connect("Yrkesprov1.db")
    cur = con.cursor()
    cur.execute('SELECT HEX FROM colors;')
    rows = cur.fetchall()

    con.close()

    
    
    values = []
    labels = []
    colors = []
   
    
    
    
    for row in data:
         values.append(row[2])
         labels.append(row[1])

    for row in rows:
         colors.append("#" + row[0])
         
         

   # for row in rows:
        # colors.append(row[1])
        # colors.append(row[2]) 
        # colors.append(row[3]) 
        

    print(data)
    #colors = "Magic Micke"           
        
    return render_template("graph.html", labels=labels, values=values, colors=colors)
    #return(values)

if __name__ == "__main__":

    app.run(port=8000, debug=True)
    

 #cur.execute('SELECT "kustannus_name", "euro_brutto" FROM PORVOO ORDER BY "euro_brutto" DESC LIMIT 5')
