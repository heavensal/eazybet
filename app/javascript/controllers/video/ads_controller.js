import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video--ads"
export default class extends Controller {
  static targets = ["video", "playButton"]

  connect() {
    console.log("Contrôleur vidéo ads connecté !");

  }

  play() {
    this.videoTarget.play();
  }
}

var videoElement;
// Define a variable to track whether there are ads loaded and initially set it to false
var adsLoaded = false;

window.addEventListener('load', function(event) {
  videoElement = document.getElementById('video-element');
  initializeIMA();
  videoElement.addEventListener('play', function(event) {
    loadAds(event);
  });
  var playButton = document.getElementById('play-button');
  playButton.addEventListener('click', function(event) {
    videoElement.play();
  });
});

window.addEventListener('resize', function(event) {
  console.log("window resized");
});

function initializeIMA() {
  console.log("initializing IMA");
}

function loadAds(event) {
  // Prevent this function from running on if there are already ads loaded
  if(adsLoaded) {
    return;
  }
  adsLoaded = true;

  // Prevent triggering immediate playback when ads are loading
  event.preventDefault();

  console.log("loading ads");
}
