import { Controller } from "@hotwired/stimulus";

// connects with data-controller="profile"
export default class extends Controller {
  static targets = ["dialog"];

  connect() {
    console.log("profile modal loaded");
  }

  open() {
    this.dialogTarget.showModal();
    document.body.style.overflow = "hidden"; // Désactive le scroll
  }

  close(event) {
    if (event.target === this.dialogTarget || event.target.id === "closeModal") {
      this.dialogTarget.close();
      document.body.style.overflow = ""; // Réactive le scroll
    }
  }
}
