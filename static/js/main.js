async function placeOrder() {
  const name = document.getElementById('name').value;
  const email = document.getElementById('email').value;
  const service = document.getElementById('service').value;
  const message = document.getElementById('message').value;
  const status = document.getElementById('order-status');

  if (!name || !email || !service) {
    status.style.color = '#ff4444';
    status.textContent = '⚠️ Please fill in all required fields!';
    return;
  }

  status.style.color = '#f0a500';
  status.textContent = '⏳ Sending your order...';

  try {
    const response = await fetch('/order', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name, email, service, message })
    });

    const data = await response.json();

    if (data.status === 'success') {
      status.style.color = '#00ff88';
      status.textContent = '✅ Order received! I will contact you soon.';
      document.getElementById('name').value = '';
      document.getElementById('email').value = '';
      document.getElementById('service').value = '';
      document.getElementById('message').value = '';
    }
  } catch (error) {
    status.style.color = '#ff4444';
    status.textContent = '❌ Something went wrong. Try again!';
  }
}

// Smooth scroll for ORDER NOW button
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    document.querySelector(this.getAttribute('href')).scrollIntoView({
      behavior: 'smooth'
    });
  });
});
