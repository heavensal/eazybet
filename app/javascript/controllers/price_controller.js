import { Controller } from "@hotwired/stimulus";

// connects with data-controller="price"
export default class extends Controller {
  static targets = ["odd", "stake", "diamond"];

  connect() {

    // this.update();
  }

  update() {
    const odd = parseFloat(this.oddTarget.innerText);
    const stake = parseFloat(this.stakeTarget.value);
    this.diamondTarget.innerText = (Math.ceil((odd * stake - stake)) / 1000).toFixed(2);
  }
}
