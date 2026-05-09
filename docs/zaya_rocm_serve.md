# ZAYA1-8B vLLM serve command on Strix-Halo (ROCm)

Use this after activating the  conda environment and making sure the GPU has enough free memory.

Environment:


Recommended launch command:


Notes:
-  was needed on this machine while other GPU consumers were present.
-  avoids compile/cudagraph startup complexity for the first successful smoke run.
- If you want higher throughput later, raise memory utilization gradually after confirming the GPU is mostly free.
- The local vLLM tree already includes the Zaya patches from Zyphra's  branch.
