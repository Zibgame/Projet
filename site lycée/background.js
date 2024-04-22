document.addEventListener("DOMContentLoaded", function() {
    var ipButton = document.getElementById("ipButton");
    ipButton.addEventListener("click", function() {
        var tempInput = document.createElement("textarea");
        tempInput.value = "goodlife.mc-srv.me";
        document.body.appendChild(tempInput);
        tempInput.select();
        document.execCommand("copy");
        document.body.removeChild(tempInput);
        var customAlert = document.createElement("div");
        customAlert.innerHTML = "Adresse IP copiée : goodlife.mc-srv.me";
        customAlert.classList.add("custom-alert"); 
        document.body.appendChild(customAlert);
        setTimeout(function() {
            document.body.removeChild(customAlert);
        }, 3000);
    });
});