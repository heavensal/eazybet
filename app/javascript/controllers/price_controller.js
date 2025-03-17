import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "result"];

  connect() {
    this.basePrice = parseFloat(this.resultTarget.textContent) || 0;
    console.log(this.basePrice);
    const res = document.getElementById('result')
    console.log(res);

  }

  update() {
    const multiplier = parseFloat(this.inputTarget.value) || 1;
    this.resultTarget.textContent = (this.basePrice * multiplier).toFixed(2);
  }
}
