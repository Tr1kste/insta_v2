const el = document.querySelector("#file_input");
if (el) {
  el.addEventListener("change", (event) => {
    const img = document.querySelector(".img_post");
    const p = document.querySelector(".newPost__leftColumn__p");
    img.src = URL.createObjectURL(event.target.files[0]);
    p.innerHTML = event.target.files[0].name;
  });
}

const avatarImg = document.querySelector("#file_input_avatar");
if (avatarImg) {
  avatarImg.addEventListener("change", (event) => {
    const img = document.querySelector("#avatar_src");
    img.src = URL.createObjectURL(event.target.files[0]);
  });
}

const linkArr = document.querySelectorAll(".nav__wrap");
for (let i = 0; i < linkArr.length; i++) {
  linkArr[i].addEventListener("click", (event) => {
    let i, contentArr, links, dataTab;

    dataTab = event.currentTarget.dataset.tab;

    contentArr = document.querySelectorAll(".profile__content");
    for (i = 0; i < contentArr.length; i++) {
      contentArr[i].classList.add("d-none");
    }
    document.getElementById(dataTab).classList.remove("d-none");

    links = document.querySelectorAll(".nav__wrap");
    for (i = 0; i < links.length; i++) {
      links[i].classList.remove("active");
    }
    event.currentTarget.classList.add("active");
  });
}
