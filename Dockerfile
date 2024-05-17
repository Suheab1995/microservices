# Dockerfile

# Use the official Python image as base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends nginx \
    && rm -rf /var/lib/apt/lists/*

# Install Gunicorn
RUN pip install gunicorn

# Install Flask
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask app into the container
COPY . /app/

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and Gunicorn
CMD service nginx start && gunicorn -b 0.0.0.0:8000 app:app
