import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  toggleFavorite(event) {
    event.preventDefault()
    const heartIcon = this.iconTarget
    const isFavorite = heartIcon.classList.contains('favorite')

    if (isFavorite) {
      heartIcon.classList.remove('favorite')
      heartIcon.style.color = '#707b8f'
    } else {
      heartIcon.classList.add('favorite')
      heartIcon.style.color = '#ec0941'
    }

    // Envoie la requête pour ajouter/supprimer des favoris
    const url = heartIcon.closest('a').href
    fetch(url, {
      method: isFavorite ? 'DELETE' : 'POST',
      headers: { 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content }
    })
  }
}
