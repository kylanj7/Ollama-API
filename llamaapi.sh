#!/bin/bash

ollama list

read -p "Enter the Model you wish to test here: " MODEL
read -p "Enter the testing prompt you wish to infer here: " PROMPT 

curl -X POST http://localhost:11434/api/generate -d '{
  "model": "'"$MODEL"'",
  "prompt": "'"$PROMPT"'",
  "stream": false
}'
