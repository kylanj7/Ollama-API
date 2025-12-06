#!/bin/bash

ollama list

read -p "Enter the Model you wish to test here: " MODEL
read -p "Enter the testing prompt you wish to infer here: " PROMPT 
read -p "Enter MAX number of tokens a.k.a response length (default 512): " TOKENS
read -p "Model Temperature (controls how consistent vs. random the model's outputs are. default 0.7): " TEMP
read -p "Enter maximum context length (larger = more memory but slower inference. default 2048): " CONTEXT
read -p "Enter top_k (larger values decrease predictable words (range: 1-100, default: 40): " TOP_K
read -p "Low values only allow high-confidence tokens, higher value allows more variety (range = 0.50-1.0): " TOP_P

# Set defaults for all parameters
TEMP=${TEMP:-0.7}
TOKENS=${TOKENS:-512}
CONTEXT=${CONTEXT:-2048}
TOP_K=${TOP_K:-40}
TOP_P=${TOP_P:-0.9}

curl -X POST http://localhost:11434/api/generate -d '{
  "model": "'"$MODEL"'",
  "prompt": "'"$PROMPT"'",
  "system": "You are being tested for development. Give complex responses that test your limits for fair evaluation.",
  "stream": false,
  "options": {
    "temperature": '"$TEMP"',
    "num_predict": '"$TOKENS"',
    "num_ctx": '"$CONTEXT"',
    "top_k": '"$TOP_K"',
    "top_p": '"$TOP_P"',
    "repeat_penalty": 1.1
  }
}' | jq -r '.response'
