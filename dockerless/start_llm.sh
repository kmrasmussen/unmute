#!/bin/bash
set -ex

# This command tells uv to create a temporary, isolated environment,
# install the specified packages into it, and then run the `vllm serve`
# command from within that environment. This avoids all PATH and
# directory issues.
uv tool run 'vllm>=0.6.0' -- \
  serve \
  --model=google/gemma-3-1b-it \
  --max-model-len=8192 \
  --dtype=bfloat16 \
  --gpu-memory-utilization=0.3 \
  --port=8091
