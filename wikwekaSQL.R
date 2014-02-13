library(RMySQL)
library(tm)

setwd("/home/propp/wikileaks/");

# retrieve data from redacted_war_diary_irq and put into individual text files

drv = dbDriver("MySQL")

con = dbConnect(drv, dbname='wikileaks', user='root', password='mandarin',
                host='127.0.0.1')

nrows = fetch(dbSendQuery(con, 'SELECT COUNT(DISTINCT id) FROM redacted_war_diary_irq'))

nr = as.numeric(nrows)

nr = 20

#rewrite as *apply
for (i in 1:nr) { 
 mydata = dbSendQuery(con, 'SELECT summary FROM redacted_war_diary_irq rwdi WHERE rwdi.id = "i"')
 data = fetch(mydata, n=1)
 dbClearResult(mydata)
 filename = cat(".txt", i)
 write(data, file="filename")
 data
}



nr = as.numeric(nrows)

nr = 20

for (i in 1:nr) { 
  query <- cat('SELECT summary FROM redacted_war_diary_irq rwdi WHERE rwdi.id = ', i)
  data = as.data.frame(dbGetQuery(con, query))
 data
 ##filename = cat(".txt", i)
 ##write(data, file="filename")
}


##########

















