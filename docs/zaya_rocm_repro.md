# Zaya on Strix-Halo ROCm reproduction

This is the shortest reliable sequence for rebuilding and running ZAYA1-8B on the AMD Strix-Halo machine.

## 1. Activate the environment


## 2. Install Zyphra Transformers fork
This is required because upstream Transformers does not recognize the  config.



## 3. Set ROCm build/runtime variables


## 4. Rebuild vLLM


## 5. Smoke test ZAYA1-8B
The working smoke test used on this machine was:



## 6. What to expect
- With the Zaya patches applied, vLLM resolves  correctly.
- If VRAM is too full, engine startup fails with a memory-availability error.
- After stopping the competing llama.cpp server, the same smoke test succeeded.

## 7. Reference comparisons
The local Zaya pieces were compared against Zyphra's  branch and matched for the checked files:
- 
- 
- 
- 
- 
- 
- 
- 
- 
- 
- 
- 
