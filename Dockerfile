FROM node:20-alpine

LABEL maintainer="Your Name <your.email@example.com>"
LABEL description="GitHub workflow image with Docker, Supabase, Netlify, npm, and Node.js"

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    docker \
    docker-cli-buildx \
    python3 \
    py3-pip \
    build-base

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install Supabase CLI
RUN curl -L https://github.com/supabase/cli/releases/latest/download/supabase_linux_amd64.tar.gz | tar -xz && \
    mv supabase /usr/local/bin/supabase && \
    chmod +x /usr/local/bin/supabase

# Install Netlify CLI
RUN npm install -g netlify-cli

# Verify installations
RUN node --version && \
    npm --version && \
    docker --version && \
    docker-compose --version && \
    supabase --version && \
    netlify --version

# Set working directory
WORKDIR /github/workspace

# Set entrypoint
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["bash"]