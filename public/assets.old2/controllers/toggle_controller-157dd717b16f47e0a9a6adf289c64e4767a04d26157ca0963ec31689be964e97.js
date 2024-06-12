import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ['extension']
  connect() {
  }

  fire() {
    this.extensionTarget.classList.toggle('d-none')
  }
};
