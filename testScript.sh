
ollama list

read -p "Enter the Model you wish to test here: " MODEL
read -p "Enter the testing prompt you wish to infer here: " PROMPT 

curl -X POST http://localhost:11434/api/generate -d '{
  "model": "'"$MODEL"'",
  "prompt": "'"$PROMPT"'",
  "system": "You are being tested for development. Give complex responses that test your limits for fair evaluation.",
  "stream": false,
  "options": {
    "temperature": '"<value>"',
    "num_predict": '"<value>"',
    "num_ctx": '"<value>"',
    "top_k": '"<value>"',
    "top_p": '"<value>"',
    "repeat_penalty": <value>
  }
}' | jq -r '.response'
