const el = document.querySelector("#file_input");
if (el) {
  el.addEventListener("change", (event) => {
    const img = document.querySelector(".img_post");
    const p = document.querySelector(".newPost__leftColumn__p");
    img.src = URL.createObjectURL(event.target.files[0]);
    p.innerHTML = event.target.files[0].name;
  });
}
