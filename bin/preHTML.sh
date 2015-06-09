#!/bin/bash

if [ !-f $1]
then
    touch $1

    echo "<!DOCTYPE html>
    <html>
    <head>
    <title>$1</title>
    </head>
    <body>
    
    </body>
    </html>"
else
    echo "Ce fichier existe déjà"
fi



