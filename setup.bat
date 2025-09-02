@echo off
REM Initialization script for ya-note project (Windows)

echo 🚀 Starting ya-note project setup...

REM Create data directory if it doesn't exist
if not exist "data" mkdir data

REM Run migrations
echo 📦 Applying database migrations...
python manage.py migrate

REM Collect static files
echo 📁 Collecting static files...
python manage.py collectstatic --noinput

REM Ask if the user wants to create a superuser
set /p response=👤 Do you want to create a superuser? (y/n):
if /i "%response%"=="y" (
    python manage.py createsuperuser
)

echo ✅ Setup completed!
echo 🌐 To start the server, run: python manage.py runserver
echo 🐳 Or use Docker: docker-compose up --build
pause
