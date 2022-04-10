import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "add_item"];

  add_association(event) {
    event.preventDefault();
    if (document.getElementById("associated_investigator_email").value != ""){
      fetch(this.data.get("url"))
        .then((resp) => resp.json())
        .then(function(result) {
          console.log(result)
          let investigators = result.data;

          console.log(investigators)

          for (var i = 0; i < investigators.length; i++){
            if (investigators[i].email == document.getElementById("associated_investigator_email").value){
              document.getElementById("row_template").content.querySelectorAll("td")[0].innerHTML = investigators[i].name;
              document.getElementById("row_template").content.querySelectorAll("td")[1].innerHTML = investigators[i].email;
              document.getElementById("row_template").content.querySelectorAll("input")[1].value = investigators[i].id;
              console.log(investigators[i]);
              break;
            }
          }

          var content = document.getElementById("row_template").innerHTML.replace(/TEMPLATE_RECORD/g, Math.floor(Math.random() * 20));
          document.getElementById("investigators_body").insertAdjacentHTML('afterbegin', content);
        })
      .catch(function(error) {
        console.log(error);
      });
    }
    

    
  }


  remove_association(event) {
    event.preventDefault();
    let item = event.target.closest(".investigator-row");
    item.querySelector("input[name*='_destroy']").value = 1;
    item.style.display = 'none';
  }


}
