# Ollama API Testing Script

A simple bash script for testing and experimenting with local Ollama LLM models through their API.

## Prerequisites

- [Ollama](https://ollama.ai/) installed and running locally
- `curl` (usually pre-installed on Linux)
- `jq` for JSON parsing (optional but recommended)

### Install jq (if needed)
```bash
# Ubuntu/Debian
sudo apt install jq

# macOS
brew install jq
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/kylanj7/Ollama-API.git
cd Ollama-API
```

2. Make the script executable:
```bash
chmod +x llamaapi.sh
```

3. Ensure Ollama is running:
```bash
ollama serve
```

## Usage

Run the script:
```bash
./llamaapi.sh
```

The script will prompt you for the following parameters:

1. **Model**: Choose from your installed Ollama models (displayed via `ollama list`)
2. **Prompt**: The question or instruction for the model
3. **Max Tokens**: Maximum response length (default: 512)
4. **Temperature**: Controls randomness (default: 0.7)
   - Lower (0.0-0.3): More deterministic, focused
   - Medium (0.5-0.9): Balanced
   - Higher (1.0+): More creative, varied
5. **Context Length**: Maximum context window (default: 2048)
6. **Top-K**: Limits token selection to top K choices (default: 40)
7. **Top-P**: Nucleus sampling threshold (default: 0.9)

### Example Session
```bash
$ ./llamaapi.sh

NAME                    ID              SIZE    MODIFIED
llama3.2:3b            abc123def       2.0 GB  2 days ago

Model: llama3.2:3b
Prompt: Explain quantum computing in simple terms
Max tokens (default 512): 
Temperature (default 0.7): 0.5
Context length (default 2048): 
Top-k (default 40): 
Top-p (default 0.9): 

[Model response appears here...]
```

## Parameters Explained

### Temperature
Controls the randomness of outputs:
- `0.0`: Deterministic, always picks the most likely token
- `0.7`: Balanced (default)
- `1.5+`: Very creative, less predictable

**Use cases:**
- Low (0.1-0.3): Code generation, factual Q&A, math
- Medium (0.5-0.9): General conversation, content writing
- High (1.0-2.0): Creative writing, brainstorming

### Top-K
Only considers the K most likely next tokens:
- Lower values (10-20): More focused outputs
- Default (40): Good balance
- Higher values (80-100): More variety

### Top-P (Nucleus Sampling)
Keeps tokens until cumulative probability reaches P:
- `0.5-0.7`: Conservative, high-confidence tokens only
- `0.9`: Standard (default)
- `0.95-1.0`: Allows more variety

### Max Tokens
Controls response length. Note: tokens ≠ words (roughly 1 token = 0.75 words)

### Context Length
Maximum tokens the model can "remember" from the conversation:
- Larger values use more memory and are slower
- Default 2048 works for most use cases

## API Endpoint

The script calls the local Ollama generate API:
```
POST http://localhost:11434/api/generate
```

## Model Management

### List available models:
```bash
ollama list
```

### Pull a new model:
```bash
ollama pull llama3.2:3b
ollama pull mistral
ollama pull codellama
```

### Remove a model:
```bash
ollama rm llama3.2:3b
```

## Customization

### Modify System Prompt
Edit the `system` field in `llamaapi.sh`:
```bash
"system": "You are a helpful coding assistant."
```

### Add More Parameters
Available options in the Ollama API:
```json
"options": {
  "seed": 42,              // For reproducible outputs
  "repeat_penalty": 1.1,   // Reduce repetition
  "stop": ["\n\n"],        // Stop sequences
  "mirostat": 0            // Alternative sampling
}
```

## Troubleshooting

### "Connection refused" error
Make sure Ollama is running:
```bash
ollama serve
```

### "Model not found" error
Pull the model first:
```bash
ollama pull llama3.2:3b
```

### No output displayed
Install `jq` or remove `| jq -r '.response'` from the script to see raw JSON

### Slow inference
- Reduce `num_ctx` (context length)
- Use a smaller model (e.g., 3B instead of 7B)
- Check CPU/GPU usage

## Performance Tips

- **3B models**: Fast on CPU, good for testing
- **7B models**: Better quality, needs decent hardware
- **13B+ models**: Best quality, GPU recommended
- Use `stream: true` for real-time token output (modify script)

## Contributing

Pull requests welcome! Some ideas:
- Add conversation history support
- Implement streaming output
- Create presets for common use cases
- Add error handling

## License

MIT License - Feel free to use and modify

## Resources

- [Ollama Documentation](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Ollama Models Library](https://ollama.ai/library)
- [LLM Parameter Tuning Guide](https://github.com/ollama/ollama/blob/main/docs/modelfile.md)

## Author

**Kylan Johnson** - [GitHub](https://github.com/kylanj7)

---

**Note**: This script runs models entirely locally on your machine. No data is sent to external servers.
