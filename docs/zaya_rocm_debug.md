# Zaya / Strix-Halo debug notes

Current status:
- Local vllm-strix-halo now matches Zyphra vllm origin/zaya1-pr for the Zaya-specific files we checked.
- ZayaForCausalLM resolves successfully.
- The current blocker is runtime initialization memory pressure, not a missing Zaya patch.

Latest verified failure:
- EngineCore init failed because free memory on cuda:0 was 52.46 / 105.47 GiB, while vLLM requested 0.85 (89.65 GiB).

Useful comparison checks used:
- git diff origin/zaya1..origin/zaya1-pr for Zaya files
- byte-for-byte compare local vs origin/zaya1-pr for:
  - vllm/model_executor/models/zaya.py
  - vllm/tool_parsers/zaya_tool_parser.py
  - vllm/transformers_utils/configs/zaya.py
  - vllm/model_executor/layers/mamba/cca.py
  - vllm/model_executor/layers/mamba/mamba_utils.py
  - vllm/v1/attention/backends/cca_attn.py
  - vllm/v1/attention/backends/registry.py
  - vllm/v1/worker/mamba_utils.py
  - vllm/model_executor/models/registry.py
  - vllm/transformers_utils/config.py
  - vllm/transformers_utils/configs/__init__.py
  - vllm/tool_parsers/__init__.py

Recommended next runtime test:
- reduce gpu_memory_utilization to something like 0.45-0.60 for a smoke test, or free VRAM by stopping other GPU jobs.


Latest verification:
- After freeing the llama.cpp server, ZAYA1-8B successfully initialized and generated output on gfx1151.
- Current smoke test: gpu_memory_utilization=0.30, enforce_eager=True, max_model_len=2048.
- Observed output: repeated "s" characters (the run completed successfully, though the sample prompt is not meaningful).
