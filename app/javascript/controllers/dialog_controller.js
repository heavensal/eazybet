import Dialog from "@stimulus-components/dialog"
export default class extends Dialog  {
  static targets = ["dialog", "team", "price"];

  open(event) {
    // Vérifie si l'événement est bien capturé

    const team = event.target.dataset.team;
    const price = event.target.dataset.price;

    this.teamTarget.textContent = team;
    this.priceTarget.textContent = price;

    // Ouvre la modal
    this.dialogTarget.showModal();
  }

  close() {
    // Ferme la modal
    this.dialogTarget.close();
  }
}
