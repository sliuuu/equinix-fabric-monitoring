# Installation Guide

## Prerequisites
- Node.js 18+
- npm or yarn
- Equinix Portal account with API access

## Quick Installation
```bash
git clone https://github.com/sliuuu/equinix-fabric-monitoring.git
cd equinix-fabric-monitoring
./setup.sh
```

## Manual Installation
1. Install n8n: `npm install n8n -g`
2. Copy environment: `cp .env.example .env`
3. Edit .env with your credentials
4. Start n8n: `n8n start`
5. Import workflow.json at http://localhost:5678
