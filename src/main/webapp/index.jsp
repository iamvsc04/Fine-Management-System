<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fines Management System - The Future of Fine Management</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(45deg, #ff6b6b, #ee5a24, #f39c12);
            --accent-gradient: linear-gradient(135deg, #667eea, #764ba2, #f093fb, #f5576c);
            --dark-gradient: linear-gradient(135deg, #0c0c0c 0%, #1a1a2e 50%, #16213e 100%);
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: #ffffff;
            background: var(--dark-gradient);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background */
        .animated-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.1;
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        .shape {
            position: absolute;
            background: var(--accent-gradient);
            border-radius: 50%;
            animation: float 20s infinite linear;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 10%;
            animation-delay: 5s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            top: 80%;
            left: 20%;
            animation-delay: 10s;
        }

        .shape:nth-child(4) {
            width: 100px;
            height: 100px;
            top: 40%;
            right: 30%;
            animation-delay: 15s;
        }

        /* Particle System */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .particle {
            position: absolute;
            width: 2px;
            height: 2px;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 50%;
            animation: particleFloat 15s infinite linear;
        }

        /* Header with Neon Effect */
        .header {
            background: rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(20px);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            border-bottom: 1px solid rgba(102, 126, 234, 0.3);
            box-shadow: 0 0 30px rgba(102, 126, 234, 0.2);
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2rem;
        }

        .logo {
            font-family: 'Orbitron', monospace;
            font-size: 1.8rem;
            font-weight: 900;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 0 30px rgba(102, 126, 234, 0.5);
            position: relative;
        }

        .logo::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--accent-gradient);
            filter: blur(10px);
            opacity: 0.3;
            z-index: -1;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2.5rem;
        }

        .nav-links a {
            text-decoration: none;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
            position: relative;
            padding: 0.5rem 1rem;
            border-radius: 25px;
        }

        .nav-links a:hover {
            color: #ffffff;
            background: rgba(102, 126, 234, 0.2);
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.4);
            transform: translateY(-2px);
        }

        /* Welcome Section with Holographic Effect */
        .welcome-section {
            text-align: center;
            padding: 2rem;
            margin-top: 100px;
            margin-bottom: 2rem;
        }

        .welcome-text {
            background: linear-gradient(45deg, rgba(102, 126, 234, 0.2), rgba(245, 87, 108, 0.2));
            backdrop-filter: blur(15px);
            border: 2px solid;
            border-image: var(--accent-gradient) 1;
            border-radius: 50px;
            padding: 1.2rem 2.5rem;
            display: inline-block;
            font-size: 1.2rem;
            font-weight: 600;
            color: #ffffff;
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
            animation: holographicGlow 3s ease-in-out infinite alternate;
            position: relative;
            overflow: hidden;
        }

        .welcome-text::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 2s infinite;
        }

        /* Hero Section with 3D Transform */
        .hero {
            text-align: center;
            padding: 6rem 2rem;
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            perspective: 1000px;
        }

        .hero-content {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            backdrop-filter: blur(25px);
            border-radius: 30px;
            padding: 5rem 4rem;
            border: 1px solid rgba(102, 126, 234, 0.3);
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.3),
                0 0 100px rgba(102, 126, 234, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            animation: float3D 6s ease-in-out infinite;
            transform-style: preserve-3d;
            position: relative;
        }

        .hero-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--accent-gradient);
            opacity: 0.05;
            border-radius: 30px;
            animation: pulseGlow 4s ease-in-out infinite;
        }

        .hero h1 {
            font-family: 'Orbitron', monospace;
            font-size: 4.5rem;
            font-weight: 900;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 2rem;
            animation: textGlow 3s ease-in-out infinite alternate;
            text-shadow: 0 0 50px rgba(102, 126, 234, 0.5);
            position: relative;
            z-index: 1;
        }

        .hero p {
            font-size: 1.4rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 3rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            font-weight: 300;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        .cta-button {
            display: inline-block;
            padding: 1.5rem 3rem;
            background: var(--secondary-gradient);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.2rem;
            transition: all 0.4s ease;
            box-shadow: 
                0 15px 35px rgba(255, 107, 107, 0.4),
                0 0 50px rgba(255, 107, 107, 0.2);
            animation: buttonPulse 2s infinite;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .cta-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .cta-button:hover::before {
            left: 100%;
        }

        .cta-button:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 
                0 25px 50px rgba(255, 107, 107, 0.6),
                0 0 80px rgba(255, 107, 107, 0.4);
        }

        /* Features Section with Card Morphing */
        .features {
            padding: 8rem 2rem;
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
        }

        .features h2 {
            text-align: center;
            font-family: 'Orbitron', monospace;
            font-size: 3rem;
            font-weight: 700;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 4rem;
            position: relative;
            z-index: 1;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 3rem;
            margin-top: 4rem;
        }

        .feature-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 3rem 2.5rem;
            text-align: center;
            border: 1px solid rgba(102, 126, 234, 0.3);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--accent-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 0;
        }

        .feature-card:hover::before {
            opacity: 0.1;
        }

        .feature-card:hover {
            transform: translateY(-15px) rotateX(5deg) rotateY(5deg);
            box-shadow: 
                0 30px 60px rgba(102, 126, 234, 0.3),
                0 0 100px rgba(102, 126, 234, 0.2);
            border-color: rgba(102, 126, 234, 0.6);
        }

        .feature-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 2rem;
            background: var(--secondary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            box-shadow: 0 15px 40px rgba(255, 107, 107, 0.4);
            position: relative;
            z-index: 1;
            animation: iconFloat 3s ease-in-out infinite;
        }

        .feature-card h3 {
            font-family: 'Orbitron', monospace;
            font-size: 1.5rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .feature-card p {
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.7;
            position: relative;
            z-index: 1;
        }

        /* Footer with Gradient Border */
        .footer {
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.8), rgba(26, 26, 46, 0.8));
            backdrop-filter: blur(20px);
            padding: 4rem 2rem 2rem;
            text-align: center;
            border-top: 1px solid rgba(102, 126, 234, 0.3);
            position: relative;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--accent-gradient);
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 3rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            padding: 0.5rem 1rem;
            border-radius: 20px;
        }

        .footer-links a:hover {
            color: #ffffff;
            background: rgba(102, 126, 234, 0.2);
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.3);
        }

        .footer p {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
        }

        /* Animations */
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.7; }
            50% { transform: translateY(-20px) rotate(180deg); opacity: 1; }
        }

        @keyframes particleFloat {
            0% { transform: translateY(100vh) translateX(0); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-100px) translateX(100px); opacity: 0; }
        }

        @keyframes holographicGlow {
            0% { box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3); }
            100% { box-shadow: 0 8px 32px rgba(245, 87, 108, 0.4); }
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        @keyframes float3D {
            0%, 100% { transform: translateY(0px) rotateX(0deg) rotateY(0deg); }
            50% { transform: translateY(-10px) rotateX(2deg) rotateY(2deg); }
        }

        @keyframes textGlow {
            0% { text-shadow: 0 0 50px rgba(102, 126, 234, 0.5); }
            100% { text-shadow: 0 0 80px rgba(245, 87, 108, 0.7); }
        }

        @keyframes pulseGlow {
            0%, 100% { opacity: 0.05; }
            50% { opacity: 0.15; }
        }

        @keyframes buttonPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-5px) rotate(5deg); }
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .nav-container {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                gap: 1.5rem;
            }

            .hero h1 {
                font-size: 3rem;
            }

            .hero p {
                font-size: 1.2rem;
            }

            .hero-content {
                padding: 3rem 2rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .footer-links {
                flex-direction: column;
                gap: 1rem;
            }

            .shape {
                display: none;
            }
        }

        @media (max-width: 480px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .features h2 {
                font-size: 2.5rem;
            }

            .feature-card {
                padding: 2rem 1.5rem;
            }

            .welcome-text {
                font-size: 1rem;
                padding: 1rem 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="animated-bg">
        <div class="floating-shapes">
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
        </div>
    </div>

    <!-- Particle System -->
    <div class="particles" id="particles"></div>

    <!-- Header -->
    <header class="header">
        <nav class="nav-container">
            <div class="logo">FMS NEXUS</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#features">Features</a></li>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Welcome Section -->
        <% if (session.getAttribute("name") != null) { %>
        <section class="welcome-section">
            <div class="welcome-text">
                ✨ Welcome back, <%= session.getAttribute("name") %>! Ready to revolutionize fine management?
            </div>
        </section>
        <% } %>

        <!-- Hero Section -->
        <section class="hero" id="home">
            <div class="hero-content">
                <h1>Simplify Fine Management</h1>
                <p>Experience the future of educational administration with our cutting-edge platform that transforms how institutions handle fines through intelligent automation and seamless user experiences.</p>
                <a href="get_started.jsp" class="cta-button">Launch Experience</a>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features" id="features">
            <h2>Revolutionary Features</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Instant Fine Processing</h3>
                    <p>Lightning-fast fine addition with AI-powered categorization and automated workflow management that reduces processing time by 90%.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🔐</div>
                    <h3>Military-Grade Security</h3>
                    <p>Advanced encryption protocols and biometric authentication ensure your financial transactions are protected with bank-level security standards.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🌐</div>
                    <h3>Neural Network Updates</h3>
                    <p>Real-time synchronization across all devices with predictive analytics that anticipate needs before they arise, powered by machine learning.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Quantum Analytics</h3>
                    <p>Advanced data visualization with predictive modeling, comprehensive audit trails, and AI-driven insights for superior administrative decision-making.</p>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="footer" id="contact">
        <div class="footer-links">
            <a href="#about">About Nexus</a>
            <a href="#privacy">Privacy Shield</a>
            <a href="#terms">Terms Matrix</a>
            <a href="#contact">Contact Hub</a>
        </div>
        <p>&copy; 2025 FMS Nexus. Pioneering the future of institutional management.</p>
    </footer>

    <script>
        // Particle System
        function createParticles() {
            const particleContainer = document.getElementById('particles');
            const particleCount = 50;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 15 + 's';
                particle.style.animationDuration = (15 + Math.random() * 10) + 's';
                particleContainer.appendChild(particle);
            }
        }

        // Smooth scrolling with easing
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Dynamic header effects
        window.addEventListener('scroll', function() {
            const header = document.querySelector('.header');
            const scrolled = window.scrollY;
            
            if (scrolled > 100) {
                header.style.background = 'rgba(0, 0, 0, 0.95)';
                header.style.boxShadow = '0 0 50px rgba(102, 126, 234, 0.3)';
            } else {
                header.style.background = 'rgba(0, 0, 0, 0.9)';
                header.style.boxShadow = '0 0 30px rgba(102, 126, 234, 0.2)';
            }
        });

        // Advanced intersection observer for feature cards
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0) rotateX(0) rotateY(0)';
                    }, index * 200);
                }
            });
        }, observerOptions);

        // Initialize feature card animations
        document.querySelectorAll('.feature-card').forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(50px) rotateX(10deg)';
            card.style.transition = 'all 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
            observer.observe(card);
        });

        // 3D tilt effect for hero content
        const heroContent = document.querySelector('.hero-content');
        if (heroContent) {
            heroContent.addEventListener('mousemove', (e) => {
                const rect = heroContent.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                const centerX = rect.width / 2;
                const centerY = rect.height / 2;
                const rotateX = (y - centerY) / 20;
                const rotateY = (centerX - x) / 20;
                
                heroContent.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateZ(10px)`;
            });

            heroContent.addEventListener('mouseleave', () => {
                heroContent.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) translateZ(0)';
            });
        }

        // Initialize particles
        createParticles();

        // Cursor trail effect
        let mouseX = 0, mouseY = 0;
        let trail = [];

        document.addEventListener('mousemove', (e) => {
            mouseX = e.clientX;
            mouseY = e.clientY;
        });

        // Initialize all effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading animation
            document.body.style.opacity = '0';
            setTimeout(() => {
                document.body.style.transition = 'opacity 1s ease-in-out';
                document.body.style.opacity = '1';
            }, 100);
        });
    </script>
</body>
</html>