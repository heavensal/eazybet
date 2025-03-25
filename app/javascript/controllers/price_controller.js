import { Controller } from "@hotwired/stimulus";

// connects with data-controller="price"
export default class extends Controller {
  static targets = ["odd", "stake", "coins", "diamonds", "moneyType"];

  connect() {
    this.update();
  }

  update() {
    const odd = parseFloat(this.oddTarget.innerText);
    const stake = parseFloat(this.stakeTarget.value) || 0;
    const selectedMoney = this.moneyTypeTarget.value; // Récupère la valeur sélectionnée

    // this.coinsTarget.innerText = (odd * stake).toFixed(2) + " 🪙";
    // this.diamondsTarget.innerText = (Math.ceil((odd * stake - stake)) / 1000).toFixed(4) + " 💎";

    this.coinsTarget.innerText = (odd * stake).toFixed(2) + " 🪙";
    this.diamondsTarget.innerText = (odd * stake).toFixed(2)+ " 💎" ;

    // Affichage conditionnel
    if (selectedMoney === "coins") {
      this.coinsTarget.style.display = "inline";
      this.diamondsTarget.style.display = "none";
    } else {
      this.coinsTarget.style.display = "none";
      this.diamondsTarget.style.display = "inline";
    }
  }
}
