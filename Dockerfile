FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements file and install dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy all source code
COPY . /app/backend

# Expose the port Django will run on
EXPOSE 8000

# Start Django application (use python3 instead of python)
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
