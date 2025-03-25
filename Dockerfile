# Stage 1: Build stage
FROM python:3.11-slim AS builder

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Final image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy dependencies from the builder stage
COPY --from=builder /install /usr/local

# Copy the application code
COPY . .

# Set the entry point
CMD ["python", "app.py"]
