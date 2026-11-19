# Changelog

## 2026-11-19: llama.cpp v1.0.0 (build b12359), built from this repo

**Breaking changes:** none for the template's defaults. llama.cpp v1.0.0 removes `--defrag-thold` (and `LLAMA_ARG_DEFRAG_THOLD`); if you added it, delete that variable before applying this update. The server also tightens its CORS, DNS-rebinding and SSRF handling and adds the opt-in flags `--allow-unauthenticated-tools` and `--media-allow-private-urls`; see the release notes if you rely on built-in tools or media URLs.

- The template now builds from `aalfath/llamacpp-server-railway-template` instead of running the image directly, so future versions arrive as Railway update notices.
- Upgraded from `server-v0.5.0` to `server-v1.0.0-b12359-b1b770d`, pinned by digest `sha256:e3032ea0712da96dec820c770626385de4322dd06619fb5829256a504bbc9375`.
- Defaults (host, port, model, alias, context size, threads, cache paths) are baked into the `Dockerfile`; the template variables keep the same names and values.
- Release notes: https://github.com/ggml-org/llama.cpp/releases/tag/v1.0.0
