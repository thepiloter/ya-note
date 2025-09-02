# 📝 Ya-Note - Django Notes System

A simple and elegant system to manage your personal notes, developed with Django.

## ✨ Features

- 📝 Create, edit, and delete notes
- 👤 User authentication system
- 🔐 Each user sees only their own notes
- 🎨 Responsive web interface
- 🔍 Friendly URLs with automatic slugs

## 🚀 Quick Start with Docker (Recommended)

### Prerequisites
- Docker and Docker Compose installed

### Run the project
```bash
# Clone the repository
git clone <repository-url>
cd ya-note

# Run with Docker Compose
docker-compose up --build
```

The project will be available at: http://localhost:8000

## 💻 Local Execution (Development)

### Prerequisites
- Python 3.8+ installed
- pip (Python package manager)

### Installation and Setup

#### On Linux/macOS:
```bash
# Clone the repository
git clone <repository-url>
cd ya-note

# Create a virtual environment
python -m venv venv
source venv/bin/activate  # Linux/macOS

# Install dependencies
pip install -r requirements.txt

# Run the setup script
chmod +x setup.sh
./setup.sh
```

#### On Windows:
```cmd
# Clone the repository
git clone <repository-url>
cd ya-note

# Create a virtual environment
python -m venv venv
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the setup script
setup.bat
```

### Manual Setup (Alternative)

If you prefer manual setup:

```bash
# Activate the virtual environment
source venv/bin/activate  # Linux/macOS
# OR
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

# Create data directory
mkdir data

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput

# Create a superuser (optional)
python manage.py createsuperuser

# Start the server
python manage.py runserver
```

## 🔧 Useful Commands

### Development
```bash
# Run development server
python manage.py runserver

# Create migrations after model changes
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run tests
pytest

# Check code style
flake8
```

### Docker
```bash
# Build and run
docker-compose up --build

# Run in background
docker-compose up -d

# View logs
docker-compose logs

# Stop services
docker-compose down

# Run Django commands in the container
docker-compose exec web python manage.py <command>
```

## 📁 Project Structure

```
ya-note/
├── 📄 manage.py              # Main Django script
├── 📄 requirements.txt       # Python dependencies
├── 📄 Dockerfile             # Docker configuration
├── 📄 docker-compose.yml     # Docker orchestration
├── 📄 setup.sh               # Setup script (Linux/macOS)
├── 📄 setup.bat              # Setup script (Windows)
├── 📁 yanote/                # Main Django settings
│   ├── settings.py           # Project settings
│   ├── urls.py               # Main URLs
│   └── wsgi.py               # WSGI interface
├── 📁 notes/                 # Main notes app
│   ├── models.py             # Data models
│   ├── views.py              # Views/Controllers
│   ├── urls.py               # App URLs
│   ├── forms.py              # Forms
│   └── migrations/           # Database migrations
├── 📁 templates/             # HTML templates
│   ├── base.html             # Base template
│   ├── notes/                # Notes-specific templates
│   └── registration/         # Authentication templates
└── 📁 data/                  # Local data (SQLite database)
```

## 🧪 Run Tests

```bash
# With virtual environment active
pytest

# Or with Docker
docker-compose exec web pytest
```

## 🌐 Main URLs

- `/` - Home page
- `/auth/login/` - Login
- `/auth/signup/` - Register
- `/auth/logout/` - Logout
- `/notes/` - Notes list
- `/add/` - Create new note
- `/edit/<slug>/` - Edit note
- `/delete/<slug>/` - Delete note
- `/admin/` - Admin panel

## ⚙️ Environment Settings

The project supports the following environment variables:

- `DEBUG`: Enables debug mode (default: False)
- `SECRET_KEY`: Django secret key (default: hardcoded key for development)
- `DATABASE_PATH`: Path to SQLite database (default: data/db.sqlite3)

## 📋 Main Dependencies

- **Django 5.1.1**: Main web framework
- **pytils 0.4.1**: Utilities for transliteration (slug generation)
- **pytest**: Test framework
- **flake8**: Code style checker
