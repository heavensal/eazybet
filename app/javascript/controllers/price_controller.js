import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "result"];

  connect() {

  }

  update() {
    const multiplier = parseFloat(this.inputTarget.value) || 1;
    this.resultTarget.textContent = (this.basePrice * multiplier - this.basePrice).toFixed(2);
  }
}
