# DevOps360 🚀

A professional AWS deployment service built with Flask & Docker.

## Services
- ☁️ AWS EC2/S3 Deploy
- 🔒 SSL Certificate Setup
- ⚙️ CI/CD Pipeline (GitHub Actions)
- 🐳 Docker & Containerization
- 🌐 Domain & DNS Setup
- 🗄️ Database Setup (RDS/MySQL)
- 📈 Auto-scaling & Load Balancer

## Tech Stack
- Python / Flask
- Docker
- Terraform
- AWS EC2
- GitHub Actions

## Run Locally
git clone https://github.com/CoderSadia/devops360.git
cd devops360
python3 -m venv venv
source venv/bin/activate
pip install flask gunicorn
python app.py

## Run with Docker
docker build -t devops360 .
docker run -d -p 5000:5000 devops360
