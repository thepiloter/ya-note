#!/bin/bash

# Initialization script for the ya-note project

echo "🚀 Starting ya-note project setup..."

# Create data directory if it doesn't exist
mkdir -p data

# Run migrations
echo "📦 Applying database migrations..."
python manage.py migrate

# Collect static files
echo "📁 Collecting static files..."
python manage.py collectstatic --noinput

# Ask if the user wants to create a superuser
echo "👤 Do you want to create a superuser? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    python manage.py createsuperuser
fi

echo "✅ Setup completed!"
echo "🌐 To start the server, run: python manage.py runserver"
echo "🐳 Or use Docker: docker-compose up --build"
