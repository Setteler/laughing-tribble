# Use official Python image as a base
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python application code into the container
COPY app.py .

# Expose the port on which the Flask app runs
EXPOSE 5000

# Specify the command to run the Flask application
CMD ["python", "app.py"]
