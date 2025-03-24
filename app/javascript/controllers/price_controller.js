import { Controller } from "@hotwired/stimulus";

// connects with data-controller="price"
export default class extends Controller {
  static targets = ["odd", "stake", "coins", "diamonds"];

  connect() {
    this.update();
  }

  update() {
    const odd = parseFloat(this.oddTarget.innerText);
    const stake = parseFloat(this.stakeTarget.value) || 0;
    this.coinsTarget.innerText = (odd * stake).toFixed(2);
    this.diamondsTarget.innerText = (Math.ceil((odd * stake - stake)) / 1000).toFixed(4);
  }
}
