import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  send(event){
    const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
    const url=event.currentTarget.dataset.path
    const country_id = event.currentTarget.dataset.countryId
    const user_id = event.currentTarget.dataset.userId
    const icon_element = event.currentTarget

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "Content-Type": "application/json", "X-CSRF-Token": csrfToken },
      body:JSON.stringify(
        {
          country_id: country_id,
          user_id: user_id
        }
      )
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data.full)
        if (data.full) {
          icon_element.classList.remove('bi-star')
          icon_element.classList.add('bi-star-fill')
        } else {
          icon_element.classList.remove('bi-star-fill')
          icon_element.classList.add('bi-star')
        }
      })


  }
}
