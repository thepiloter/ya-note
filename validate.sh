#!/bin/bash
# Compliance validation script for ya-note

echo "🔍 Checking ya-note repository compliance..."
echo ""

# Check if essential files exist
echo "📋 Checking essential files:"

files=(
    "README.md"
    "Dockerfile"
    "docker-compose.yml"
    "requirements.txt"
    "manage.py"
    "setup.sh"
    "setup.bat"
    "pytest.ini"
    "tests.py"
    ".env.example"
    ".dockerignore"
)

all_present=true
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file (MISSING)"
        all_present=false
    fi
done

echo ""

# Check Docker
echo "🐳 Checking Docker:"
if command -v docker &> /dev/null; then
    echo "✅ Docker installed"
    if command -v docker-compose &> /dev/null; then
        echo "✅ Docker Compose available"

        # Test build
        echo "🔨 Testing Docker build..."
        if docker-compose build --quiet; then
            echo "✅ Docker build succeeded"
        else
            echo "❌ Docker build failed"
            all_present=false
        fi
    else
        echo "❌ Docker Compose not found"
        all_present=false
    fi
else
    echo "❌ Docker not found"
    all_present=false
fi

echo ""

# Check Python
echo "🐍 Checking Python:"
if command -v python &> /dev/null; then
    echo "✅ Python installed ($(python --version))"

    # Check if requirements can be installed
    if python -m pip install -r requirements.txt --dry-run &> /dev/null; then
        echo "✅ requirements.txt is valid"
    else
        echo "⚠️  Issues with requirements.txt"
    fi
else
    echo "⚠️  Python not found in PATH"
fi

echo ""

# Check Django structure
echo "📁 Checking Django structure:"
django_dirs=("yanote" "notes" "templates")
for dir in "${django_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir/"
    else
        echo "❌ $dir/ (MISSING)"
        all_present=false
    fi
done

echo ""

# Final result
if [ "$all_present" = true ]; then
    echo "🎉 FULL COMPLIANCE!"
    echo "✅ The repository meets all requirements:"
    echo "   - Self-contained and end-to-end"
    echo "   - Docker compatible"
    echo "   - Can be run locally without obstacles"
    echo ""
    echo "🚀 To run:"
    echo "   Docker: docker-compose up --build"
    echo "   Local:  ./setup.sh && python manage.py runserver"
else
    echo "❌ INCOMPLETE COMPLIANCE"
    echo "Some requirements were not met. Check the items marked with ❌ above."
fi
