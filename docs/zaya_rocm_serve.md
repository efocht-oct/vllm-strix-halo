# ZAYA1-8B vLLM serve command on Strix-Halo (ROCm)

Use this after activating the `zaya-env` conda environment and making sure the GPU has enough free memory.

## Environment

```bash
source ~/miniforge3/bin/activate
conda activate zaya-env
cd ~/vllm-strix-halo

export VLLM_TARGET_DEVICE=rocm
export PYTORCH_ROCM_ARCH=gfx1151
export CC=/opt/rocm/llvm/bin/clang
export CXX=/opt/rocm/llvm/bin/clang++
export CMAKE_PREFIX_PATH=/opt/rocm
```

## Recommended serve command

```bash
python3 -m vllm.entrypoints.openai.api_server   --model Zyphra/ZAYA1-8B   --trust-remote-code   --dtype bfloat16   --max-model-len 2048   --gpu-memory-utilization 0.30   --enforce-eager   --served-model-name zaya1-8b   --port 8010
```

## Example request

Once the server is running, you can test it with:

```bash
curl http://127.0.0.1:8010/v1/chat/completions   -H 'Content-Type: application/json'   -d '{
    "model": "zaya1-8b",
    "messages": [
      {"role": "user", "content": "Write a short haiku about Strix-Halo."}
    ],
    "temperature": 0.0,
    "max_tokens": 64
  }'
```

## Notes

- `--gpu-memory-utilization 0.30` was needed on this machine while other GPU consumers were present.
- `--enforce-eager` avoids compile/cudagraph startup complexity for the first successful smoke run.
- If you want higher throughput later, raise memory utilization gradually after confirming the GPU is mostly free.
- The local vLLM tree already includes the Zaya patches from Zyphra's `zaya1-pr` branch.
