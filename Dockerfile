FROM python:3.9-slim

# Set up working directory
WORKDIR /app

# Copy dependencies file
COPY app.py .

# Install dependencies
RUN pip install flask

# Copy application code
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
