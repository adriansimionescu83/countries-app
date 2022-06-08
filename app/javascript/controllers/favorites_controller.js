import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets=[setFavorite, resetFavorite]

    connect() {
        console.log("hello")
    }

    setFav() {
      console.log("Hello")
    }

    resetFav() {
      console.log("Hello")
    }

}
