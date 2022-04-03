import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "elements" ]

  change(event) {
    let added_investigators = []
    if (document.getElementsByTagName("tr").length > 1){
        console.log(document.getElementsByTagName("td")[1].innerHTML)
        for (var i = 1; i < document.getElementsByTagName("tr").length; i++){
            added_investigators.push(document.getElementsByTagName("tr")[i].getElementsByTagName("td")[1].innerHTML)
        }
    }
        
    fetch(this.data.get("url"), { 
      method: 'POST', 
      body: JSON.stringify( { investigator: [document.getElementById("associated_investigator_email").value], investigators: added_investigators }),
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

  delete(event) {
    console.log(this.data)
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