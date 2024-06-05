import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
  }

  fire(event) {
    console.log('coucou')
    console.log(event.currentTarget)
  }
}
