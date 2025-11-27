
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

echo "********** Performance Metrics **********"
EVAL_COUNT=$(echo "$RESPONSE" | jq -r '.eval_count')
EVAL_DURATION=$(echo "$RESPONSE" | jq -r '.eval_duration')
TOTAL_DURATION=$(echo "$RESPONSE" | jq -r '.total_duration')

TOKENS_PER_SEC=$(echo "scale=10; $EVAL_COUNT / $EVAL_DURATION" | bc)

echo "Tokens generated: $EVAL_COUNT"
echo "Generation time: $(echo "scale=2; $EVAL_DURATION / 1000000000" | bc)s"
echo "Total time: $(echo "scale=2; $TOTAL_DURATION / 1000000000" | bc)s"
echo "Tokens/second: $TOKENS_PER_SEC"
