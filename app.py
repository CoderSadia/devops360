from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    services = [
        {"icon": "☁️", "title": "AWS EC2/S3 Deploy", "desc": "Your app live on AWS in hours"},
        {"icon": "🔒", "title": "SSL Certificate", "desc": "Secure HTTPS setup, free SSL"},
        {"icon": "⚙️", "title": "CI/CD Pipeline", "desc": "GitHub Actions auto-deploy"},
        {"icon": "🐳", "title": "Docker & Containers", "desc": "Containerize any app"},
        {"icon": "🌐", "title": "Domain & DNS", "desc": "Point domain to your server"},
        {"icon": "🗄️", "title": "Database Setup", "desc": "MySQL / RDS on AWS"},
        {"icon": "📈", "title": "Auto-scaling", "desc": "Load balancer & scaling"},
    ]
    return render_template('index.html', services=services)

@app.route('/order', methods=['POST'])
def order():
    data = request.json
    print(f"New Order: {data}")
    return jsonify({"status": "success", "message": "Order received!"})

if __name__ == '__main__':
    app.run(debug=True)
