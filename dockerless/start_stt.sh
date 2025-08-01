#!/bin/bash
set -ex
cd "$(dirname "$0")/"

# This is part of a hack to get dependencies needed for the TTS Rust server, because it integrates a Python component
[ -f pyproject.toml ] || wget https://raw.githubusercontent.com/kyutai-labs/moshi/9837ca328d58deef5d7a4fe95a0fb49c902ec0ae/rust/moshi-server/pyproject.toml
[ -f uv.lock ] || wget https://raw.githubusercontent.com/kyutai-labs/moshi/9837ca328d58deef5d7a4fe95a0fb49c902ec0ae/rust/moshi-server/uv.lock

uv venv
source .venv/bin/activate

cd ..

# This env var must be set to get the correct environment for the Rust build.
# Must be set before running `cargo install`!
export LD_LIBRARY_PATH=$(python -c 'import sysconfig; print(sysconfig.get_config_var("LIBDIR"))')

# A fix for building Sentencepiece on GCC 15, see: https://github.com/google/sentencepiece/issues/1108
export CXXFLAGS="-include cstdint"

cargo install --features cuda moshi-server@0.6.3
moshi-server worker --config services/moshi-server/configs/stt.toml --port 8090
