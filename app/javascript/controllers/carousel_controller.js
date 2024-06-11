import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("merci");
  }

  scroll(event) {
    console.log("scrolling");
    console.log(event);
  }

  end(event) {
    console.log("end");
    console.log(event);
  }
}
