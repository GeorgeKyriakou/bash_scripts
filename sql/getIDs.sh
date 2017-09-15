#!/bin/bash

echo "Wabba lubba dub duuub!!!"
mysql -u xxxx -p yyyyyyy -D llllllll
while IFS=, read col1
do
    #echo "I got:$col1"
    echo "IF (productID = $col1 AND localeID = 1 AND isEnabled = 1) THEN"
    echo "UPDATE db.PLocale SET isEnabled = 1 WHERE localeID = 2 AND productID =$col1;"
    echo "UPDATE db.PLocale SET isEnabled = 1 WHERE localeID = 3 AND productID =$col1;"
    echo "UPDATE db.PLocale SET isEnabled = 1 WHERE localeID = 4 AND productID =$col1;"
    echo "UPDATE db.PLocale SET isEnabled = 1 WHERE localeID = 5 AND productID =$col1;"
    echo "UPDATE db.PLocale SET isEnabled = 1 WHERE localeID = 6 AND productID =$col1;"
    echo "END IF"

done < csvValuesCPY.csv
