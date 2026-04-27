# 1. Use the latest stable Ubuntu LTS
FROM ubuntu:24.04

# 2. Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# 3. Install core build tools and dependencies
# We combine these to keep the image small and efficient
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    python3 \
    python3-pip \
    python3-venv \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/QuecPython/toolchain/releases/download/V1.1.0/helios-toolchain" -o /root/helios-toolchain \
    && chmod +x /root/helios-toolchain \
    && /root/helios-toolchain \
    && find / -name "*helios*" \
    && ls -l /helios

RUN echo "Tool installed successfully!"

# 4. Set the working directory
# GitHub Actions clones your code into this path by default
WORKDIR /github/workspace

# 5. Verify the tools were installed correctly
RUN arm-none-eabi-gcc --version && python3 --version
