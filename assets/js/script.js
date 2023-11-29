/*Effet de scroll : lorsqu'on descend vers la présentations notre mot bonheur monte*/
let text = document.getElementById("text");
window.addEventListener("scroll", function(){
    let value = window.scrollY;
    text.style.marginBottom = value * 2 + "px";
})


/*Fonction pour ouvrir nos tableaux dans une nouvelle petite fenêtre*/
function openPopup(link) {
    var popupWindow = window.open(link, 'Nom de la Fenêtre', 'width=1200,height=600');
}

