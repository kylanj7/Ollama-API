# Ollama API Testing Script

A collection of bash scripts for testing and experimenting with local Ollama LLM models through their API. Run AI models entirely on your own hardware with full control over inference parameters.

## What is Ollama?

Ollama is a lightweight framework that allows you to run large language models (LLMs) locally on your machine. No internet connection required for inference, and your data never leaves your device.

## Installing Ollama

### Linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Start Ollama Service
After installation, start the Ollama server:
```bash
ollama serve
```

This runs Ollama on `http://localhost:11434`

### Pull Your First Model
```bash
# Download a small, fast model (recommended for testing)
ollama pull llama3.2:3b

# Or other models:
ollama pull mistral
ollama pull codellama
ollama pull llama3.2:1b  # Smallest, fastest
```

## Prerequisites

- [Ollama](https://ollama.ai/) installed and running locally
- `curl` (usually pre-installed on Linux)
- `jq` for JSON parsing (optional but recommended for clean output)

### Install jq (if needed)
```bash
# Ubuntu/Debian
sudo apt install jq
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/kylanj7/Ollama-API.git
cd Ollama-API
```

2. Make the scripts executable:
```bash
chmod +x llamaapi.sh
chmod +x moreControl.sh
chmod +x testScript.sh
```

3. Ensure Ollama is running:
```bash
ollama serve
```

## Scripts Overview

This repository contains three scripts for different testing workflows:

### 1. `llamaapi.sh` - Basic Testing & Model Discovery

**Purpose**: Quick testing and initial model evaluation. Use this to pull models and verify they work on your device.

**Best for**:
- First-time testing of a new model
- Quick inference checks
- Verifying Ollama installation
- Simple queries with default parameters

**Usage**:
```bash
./llamaapi.sh
```

Prompts for:
- Model selection (shows available models)
- Prompt text

Uses sensible defaults for all inference parameters.

---

### 2. `moreControl.sh` - Fine-Tuning Inference Parameters

**Purpose**: Experiment with and fine-tune all available inference parameters to optimize for your specific use case.

**Best for**:
- Finding optimal parameters for your hardware
- Testing different temperature/sampling strategies
- Comparing model behavior across settings
- Discovering what works best for your task type

**Usage**:
```bash
./moreControl.sh
```

Prompts for:
- Model selection
- Prompt text
- Max tokens (response length)
- Temperature (creativity control)
- Context length (memory window)
- Top-K sampling
- Top-P (nucleus sampling)

**Example workflow**:
1. Start with defaults
2. Adjust temperature for your task (low for facts, high for creativity)
3. Tune top-k/top-p for desired variety
4. Note which settings work best
5. Use those settings in `testScript.sh`

---

### 3. `testScript.sh` - Production Testing with Known Parameters

**Purpose**: Quickly test with your optimized parameters without being prompted each time.

**Best for**:
- Testing with parameters you've already determined work well
- Batch testing multiple prompts
- Scripted/automated testing
- Production-ready inference

**Usage**:
Edit the script to hardcode your preferred parameters, then run:
```bash
./testScript.sh
```

**How to customize**:
1. Open `testScript.sh` in your editor
2. Set your optimal parameters found via `moreControl.sh`:
```bash
MODEL="llama3.2:3b"
TEMP="0.5"
TOKENS="512"
TOP_K="40"
TOP_P="0.9"
```
3. Save and run for consistent testing

---

## Recommended Workflow
```
1. Install Ollama & pull models
         ↓
2. Run llamaapi.sh (quick verification)
         ↓
3. Run moreControl.sh (find optimal settings)
         ↓
4. Edit testScript.sh (hardcode your settings)
         ↓
5. Run testScript.sh (production testing)
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

The scripts call the local Ollama generate API:
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
Edit the `system` field in your script:
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
Install htop & nvtop to monitor local machine resources:
```bash
sudo apt install nvtop
sudo apt install htop
```

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
