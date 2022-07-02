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
