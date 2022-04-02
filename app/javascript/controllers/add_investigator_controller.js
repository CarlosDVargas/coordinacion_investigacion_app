import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "elements" ]

  change(event) {
    console.log(document.getElementById("associated_investigator_email").value)
    fetch(this.data.get("url"), { 
      method: 'POST', 
      body: JSON.stringify( { investigator: [document.getElementById("associated_investigator_email").value] }),
      credentials: "include",
      dataType: 'script',
      headers: {
        "X-CSRF-Token": getMetaValue("csrf-token"),
        "Content-Type": "application/json"
      },
    })
      .then(response => response.text())
      .then(html => {
        this.elementsTarget.innerHTML = html
      })
  }

}

function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute("content")
}