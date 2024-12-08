    <footer style="background-color: #2c3e50; color: white; text-align: center; padding: 15px 0; margin-top: 20px;">
        <p>&copy; <%= java.time.Year.now().getValue() %> Fines Management System. All Rights Reserved.</p>
        <p>Developed for Educational Purposes</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const messages = document.querySelectorAll('.alert');
            messages.forEach(message => {
                setTimeout(() => {
                    message.style.transition = 'opacity 1s';
                    message.style.opacity = 0;
                    setTimeout(() => message.remove(), 1000);
                }, 5000);
            });
        });
    </script>