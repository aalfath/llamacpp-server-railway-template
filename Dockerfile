# llama.cpp server (llama-server), CPU build, official image pinned by version and digest.
# Upstream: https://github.com/ggml-org/llama.cpp/releases/tag/v1.0.0
FROM ghcr.io/ggml-org/llama.cpp:server-v1.0.0-b12359-b1b770d@sha256:e3032ea0712da96dec820c770626385de4322dd06619fb5829256a504bbc9375

# Defaults for a small CPU deployment. Every value can be overridden with a
# Railway variable of the same name (llama-server reads LLAMA_ARG_* itself).
ENV LLAMA_ARG_HOST=:: \
    LLAMA_ARG_PORT=8080 \
    LLAMA_ARG_HF_REPO=ggml-org/Qwen3-0.6B-GGUF \
    LLAMA_ARG_ALIAS=qwen3-0.6b \
    LLAMA_ARG_CTX_SIZE=4096 \
    LLAMA_ARG_THREADS=4 \
    LLAMA_CACHE=/models \
    HF_HOME=/models/hf

EXPOSE 8080

# The base image's ENTRYPOINT is /app/llama-server; no extra arguments are needed
# because all settings come from the environment above.
