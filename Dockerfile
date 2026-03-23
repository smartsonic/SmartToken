FROM python:3.11-slim

LABEL maintainer="SmartToken Team <team@smarttoken.dev>"
LABEL description="AI Smart Router for OpenClaw"

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy application
COPY pyproject.toml README.md LICENSE ./
COPY smarttoken/ ./smarttoken/

# Install Python dependencies
RUN pip install --no-cache-dir -e .

# Create data directory
RUN mkdir -p /data

# Expose port
EXPOSE 8080

# Environment defaults
ENV SMARTTOKEN_DATA_DIR=/data
ENV SMARTTOKEN_PORT=8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Run the gateway
CMD ["smarttoken", "run", "--host", "0.0.0.0", "--port", "8080"]

# Default user
USER nobody
