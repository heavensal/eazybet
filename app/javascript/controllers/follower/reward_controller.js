import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="follower--reward"
export default class extends Controller {
  static targets = ["instagram-btn", "telegram-btn", "x-btn", "youtube-btn", "tiktok-btn"]
  connect() {

  }

  instagramClaim() {
    window.open("https://www.instagram.com/eazybetcoin", "_blank");
  }

  telegramClaim() {
    window.open("https://t.me/eazybetcoin", "_blank");
  }

  xClaim() {
    window.open("https://x.com/eazybetcoin", "_blank");
  }

  youtubeClaim() {
    window.open("https://www.youtube.com/@eazybetcoin", "_blank");
  }

  tiktokClaim() {
    window.open("https://www.tiktok.com/@eazybetcoin", "_blank");
  }
}
