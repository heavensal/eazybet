import Dialog from "@stimulus-components/dialog"
export default class extends Dialog  {
  static targets = ["dialog", "team", "price"];

  open(event) {
    // Vérifie si l'événement est bien capturé
    console.log("Opening dialog with:", event.target.dataset);

    const team = event.target.dataset.team;
    const price = event.target.dataset.price;

    // Vérifie les données récupérées
    console.log("Team:", team, "Price:", price);

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
