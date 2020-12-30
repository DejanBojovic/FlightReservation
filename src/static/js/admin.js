// flights search
const infoFlights = document.querySelectorAll(".f")
const inputFlights = document.querySelector(".info-f input")

inputFlights.addEventListener('input', () => {
    if(inputFlights.value.length === 0) {
        for(let i = 0; i < infoFlights.length; i++) {
            infoFlights[i].style.display = ""
        }
    }

    for(let i = 0; i < infoFlights.length; i++) {
        if((infoFlights[i].innerText).includes(inputFlights.value)) {
            console.log(infoFlights[i])
            infoFlights[i].style.display = ""
        } else {
            infoFlights[i].style.display = "none"
        }
    }
})

// users search
const infoUsers = document.querySelectorAll(".u p:first-child")
const inputUsers = document.querySelector(".info-u input")

inputUsers.addEventListener('input', () => {
    if(inputUsers.value.length === 0) {
        for(let i = 0; i < infoUsers.length; i++) {
            infoUsers[i].parentElement.style.display = ""
        }
    }

    for(let i = 0; i < infoUsers.length; i++) {
        if((infoUsers[i].innerText).includes(inputUsers.value)) {
            console.log(infoUsers[i])
            infoUsers[i].parentElement.style.display = ""
        } else {
            infoUsers[i].parentElement.style.display = "none"
        }
    }
})

// reservations search
const infoRes = document.querySelectorAll(".r")
const inputRes = document.querySelector(".info-r input")

inputRes.addEventListener('input', () => {
    if(inputRes.value.length === 0) {
        for(let i = 0; i < infoRes.length; i++) {
            infoRes[i].style.display = ""
        }
    }

    for(let i = 0; i < infoRes.length; i++) {
        if((infoRes[i].innerText).includes(inputRes.value)) {
            console.log(infoRes[i])
            infoRes[i].style.display = ""
        } else {
            infoRes[i].style.display = "none"
        }
    }
})