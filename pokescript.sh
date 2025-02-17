#!/bin/bash 

if [[ -z "$1" ]]; then
    echo "Falta el nombre del Pokémon."
    exit 1
fi

response=$(curl -s -4 --max-time 5 "https://pokeapi.co/api/v2/pokemon/$1")

if [[ -z "$response" ]]; then
    echo "Error"
    exit 1
fi

id=$(echo "$response" | jq '.id')
name=$(echo "$response" | jq -r '.name')
weight=$(echo "$response" | jq '.weight')
height=$(echo "$response" | jq '.height')
order=$(echo "$response" | jq '.order')

if [[ -z "$id" || "$id" == "null" ]]; then
    echo "No se encontró a $1."
    exit 1
fi

echo "$name (No. $order)"
echo "Id: $id"
echo "Weight: $weight"
echo "Height: $height"

if [[ ! -f "data.csv" ]]; then
    echo "id,name,weight,height,order" > "data.csv"
fi

echo "$id,$name,$weight,$height,$order" >> "data.csv"
