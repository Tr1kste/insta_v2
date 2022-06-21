window.onload = function () {
  const el = document.querySelector("#file_input");
  if (el) {
    el.addEventListener("change", (event) => {
      const img = document.querySelector(".newPost__leftColumn__img");
      const p = document.querySelector(".newPost__leftColumn__p");
      img.src = URL.createObjectURL(event.target.files[0]);
      p.innerHTML = event.target.files[0].name;
    });
  }
};
