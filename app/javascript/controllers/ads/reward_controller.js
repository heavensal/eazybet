import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ads--reward"
export default class extends Controller {

  static targets = ["video", "claim"]

  connect() {
    this.videoTarget.controls = false
    this.lastTime = 0
    this.isCompleted = false

    this.videoTarget.addEventListener("timeupdate", () => {
      if (this.videoTarget.currentTime > this.lastTime + 1 && !this.videoTarget.seeking) {
        this.videoTarget.currentTime = this.lastTime
      } else {
        this.lastTime = this.videoTarget.currentTime
      }
    })

    this.videoTarget.addEventListener("ended", () => {
      this.isCompleted = true
      this.claimTarget.classList.remove("hidden")
      this.claimTarget.classList.add("flex")
    })
  }

  togglePlay() {
    if (this.videoTarget.paused) {
      this.videoTarget.play()
    } else {
      this.videoTarget.pause()
    }
  }
}
