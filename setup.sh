#!/bin/bash

# Equinix Fabric Monitoring - Quick Setup Script
# This script helps set up the monitoring workflow quickly

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/setup.log"

# Functions
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}✅ $1${NC}" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}❌ $1${NC}" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}ℹ️  $1${NC}" | tee -a "$LOG_FILE"
}

# Banner
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                 Equinix Fabric Monitoring                   ║"
echo "║                    Quick Setup Script                       ║"
echo "║                                                              ║"
echo "║  This script will help you set up n8n workflow monitoring   ║"
echo "║  for Equinix Fabric infrastructure.                         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo

# Initialize log
log "Starting Equinix Fabric Monitoring setup"

# Check prerequisites
info "Checking prerequisites..."

# Check Node.js
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    success "Node.js found: $NODE_VERSION"
else
    error "Node.js not found. Please install Node.js 18+ from https://nodejs.org"
    exit 1
fi

# Check npm
if command -v npm >/dev/null 2>&1; then
    NPM_VERSION=$(npm --version)
    success "npm found: $NPM_VERSION"
else
    error "npm not found. Please install npm"
    exit 1
fi

# Check if n8n is installed
if command -v n8n >/dev/null 2>&1; then
    N8N_VERSION=$(n8n --version)
    success "n8n found: $N8N_VERSION"
else
    warning "n8n not found. Installing n8n globally..."
    npm install n8n -g
    success "n8n installed successfully"
fi

# Setup environment
info "Setting up environment configuration..."

if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        success "Created .env file from template"
        warning "Please edit .env file with your Equinix credentials before running the workflow"
    else
        error ".env.example not found. Please ensure all project files are present."
        exit 1
    fi
else
    warning ".env file already exists. Skipping environment setup."
fi

# Setup project structure
info "Setting up project structure..."

# Create necessary directories
mkdir -p logs backups docs configs examples tests

# Set permissions
chmod 755 logs backups

success "Project structure created"

echo ""
echo -e "${GREEN}🎉 Setup complete! Next steps:${NC}"
echo "1. Edit .env with your Equinix API credentials"
echo "2. Run: n8n start"
echo "3. Import workflow.json in n8n UI at http://localhost:5678"
echo "4. Configure SMTP credentials in n8n settings"
echo "5. Test and activate the workflow"
echo ""
echo -e "${BLUE}📚 Documentation:${NC}"
echo "- Installation Guide: README.md"
echo "- Configuration: .env.example"
echo "- Security Policy: SECURITY.md (if available)"
echo ""
echo -e "${BLUE}🔧 Support:${NC}"
echo "- GitHub Issues: https://github.com/sliuuu/equinix-fabric-monitoring/issues"
echo "- n8n Community: https://community.n8n.io"
echo ""
echo -e "${YELLOW}⚠️  Important:${NC}"
echo "- Never commit .env file to version control"
echo "- Use strong, unique API credentials"
echo "- Test thoroughly before production deployment"
