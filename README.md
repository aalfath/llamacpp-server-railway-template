[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/llamacpp-server?utm_medium=integration&utm_source=button&utm_campaign=llamacpp-server)

# llama.cpp Server on Railway

This repo is the source of the [llama.cpp Server](https://railway.com/deploy/llamacpp-server) Railway template. It runs [llama.cpp](https://github.com/ggml-org/llama.cpp)'s `llama-server` on CPU with an OpenAI-compatible API.

- **Version:** llama.cpp v1.0.0 (build b12359), official image `ghcr.io/ggml-org/llama.cpp:server-v1.0.0-b12359-b1b770d`, pinned by digest in the [`Dockerfile`](Dockerfile).
- **Default model:** `ggml-org/Qwen3-0.6B-GGUF`, downloaded from Hugging Face on first start into the volume at `/models` and reused after restarts and redeploys.
- **Auth:** every API request needs the generated `LLAMA_API_KEY` as a bearer token. `/health` answers without a key, for Railway's health check.

## Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `LLAMA_API_KEY` | generated, 48 characters | Bearer token for every API request |
| `LLAMA_ARG_HF_REPO` | `ggml-org/Qwen3-0.6B-GGUF` | Hugging Face GGUF repo to serve (append `:Q4_K_M` to pick a quantization) |
| `LLAMA_ARG_ALIAS` | `qwen3-0.6b` | Model name the API reports and accepts |
| `LLAMA_ARG_CTX_SIZE` | `4096` | Context size in tokens |
| `LLAMA_ARG_THREADS` | `4` | CPU threads. Containers see all host cores, so keep this at or below your plan's vCPUs |
| `LLAMA_ARG_HOST`, `LLAMA_ARG_PORT`, `PORT` | `::`, `8080` | Listen on IPv4 and IPv6, port 8080 |
| `LLAMA_CACHE`, `HF_HOME` | `/models`, `/models/hf` | Model cache on the volume |
| `OPENAI_BASE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}/v1` | Public base URL, for reference from other services |
| `OPENAI_PRIVATE_BASE_URL` | `http://${{RAILWAY_PRIVATE_DOMAIN}}:8080/v1` | Private-network base URL |

The same defaults are baked into the `Dockerfile`, so a variable you delete falls back to them. Any other `LLAMA_ARG_*` setting from the [server docs](https://github.com/ggml-org/llama.cpp/tree/master/tools/server) can be added as a variable. Larger models need more memory and CPU than the default.

```bash
curl "$OPENAI_BASE_URL/chat/completions" -H "Authorization: Bearer $LLAMA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "qwen3-0.6b", "messages": [{"role": "user", "content": "Hello"}]}'
```

## How updates reach you

The template builds this repo's `main` branch. When a new llama.cpp release is pinned here, Railway shows deployers an "update available" notice, and you choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first: breaking changes are listed at the top of each entry. Your model files stay on the volume across updates.
