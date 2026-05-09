#!/usr/bin/env bash
set -euo pipefail

# Reproduce the ZAYA1-8B environment on AMD Strix-Halo (gfx1151).
# Requires: conda, ROCm, and a free-ish GPU.

source ~/miniforge3/bin/activate
conda activate zaya-env
cd ~/vllm-strix-halo

pip install --force-reinstall --no-deps   'transformers @ git+https://github.com/Zyphra/transformers.git@zaya1'

export VLLM_TARGET_DEVICE=rocm
export PYTORCH_ROCM_ARCH=gfx1151
export CC=/opt/rocm/llvm/bin/clang
export CXX=/opt/rocm/llvm/bin/clang++
export CMAKE_PREFIX_PATH=/opt/rocm

rm -rf build/ .deps/
pip install --no-build-isolation -e .

python3 - <<'PY'
import os
os.environ['VLLM_TARGET_DEVICE'] = 'rocm'
os.environ['PYTORCH_ROCM_ARCH'] = 'gfx1151'

from vllm import LLM, SamplingParams

llm = LLM(
    model='Zyphra/ZAYA1-8B',
    trust_remote_code=True,
    tensor_parallel_size=1,
    dtype='bfloat16',
    max_model_len=2048,
    gpu_memory_utilization=0.30,
    enforce_eager=True,
)
params = SamplingParams(max_tokens=16, temperature=0.0)
out = llm.generate(['Hello from Strix-Halo.'], params)
print(out[0].outputs[0].text)
PY
