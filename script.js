document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("myForm").addEventListener("submit", function(event) {
        // Prevent default form submission
        event.preventDefault();

        // Get form data
        var formData = new FormData(this);

        // Example: You can construct the new URL dynamically based on form data
        var url = "nav-bar.html?" + new URLSearchParams(formData).toString();

        // Update iframe source with new content
        document.getElementById("myIframe").src = url;
    });
});