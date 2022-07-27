import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["outputImg", "outputName", "input"];
  fileInput() {
    const input = this.inputTarget;
    const outputImg = this.outputImgTarget;
    const outputName = this.outputNameTarget;
    const reader = new FileReader();
    reader.readAsDataURL(input.files[0]);

    reader.onload = function () {
      outputImg.src = reader.result;
      outputName.textContent = input.files[0].name;
    };
  }

  fileInputAvatar() {
    const input = this.inputTarget;
    const outputImg = this.outputImgTarget;
    const reader = new FileReader();
    reader.readAsDataURL(input.files[0]);

    reader.onload = function () {
      outputImg.src = reader.result;
    };
  }
}
