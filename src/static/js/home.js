const removeButtons = document.querySelectorAll("#remove")

for(let i = 0; i < removeButtons.length; i++) {
    removeButtons[i].addEventListener("click", (event) => {
        event.target.parentElement.style.display = "none"
    })
}

setTimeout(() => {
    document.querySelector(".msg-home").style.display = "none"
}, 3000)