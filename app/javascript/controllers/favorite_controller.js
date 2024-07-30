// app/javascript/controllers/favorite_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  toggleFavorite(event) {
    event.preventDefault()
    const heartIcon = this.iconTarget
    const isFavorite = heartIcon.classList.contains('favorite')

    // Envoie la requête pour ajouter/supprimer des favoris
    const form = event.target.closest('form')
    fetch(form.action, {
      method: form.method,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'text/vnd.turbo-stream.html'
      },
      body: new FormData(form)
    })
    .then(response => response.text())
    .then(html => {
      if (isFavorite) {
        heartIcon.classList.remove('favorite')
        heartIcon.style.color = '#707b8f'
      } else {
        heartIcon.classList.add('favorite')
        heartIcon.style.color = '#ec0941'
      }
    })
  }
}
