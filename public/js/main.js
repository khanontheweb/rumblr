signInButton = document.getElementById("sign-in-button");
signInContent = document.getElementById("sign-in-toggle-content");
signUpButton = document.getElementById("sign-up-button");
signUpContent = document.getElementById("sign-up-toggle-content");

signInButton.addEventListener("click", function() {
  if (signUpButton.classList.contains("show"))
    $('#sign-up-button').collapse('toggle');
  if (signUpContent.classList.contains("show"))
    $('#sign-up-toggle-content').collapse('toggle');
});

signUpButton.addEventListener("click", function() {
  if (signInButton.classList.contains("show"))
    $('#sign-in-button').collapse('toggle');
  if (signInContent.classList.contains("show"))
    $('#sign-in-toggle-content').collapse('toggle');
});
