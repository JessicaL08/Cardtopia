import { Controller } from "@hotwired/stimulus"
import Hammer from "hammerjs"

export default class extends Controller {
  static targets = ['card', 'board']
  static values = {
    pokemon: String
  }

  connect() {
    this.handle()
  }

  handle() {
    this.cards = this.cardTargets

    if (this.cards.length > 0) {
      this.topCard = this.cards[0]
      console.log(this.topCard);
      this.hammer = new Hammer(this.topCard)
      this.hammer.add(new Hammer.Pan({
        position: Hammer.position_ALL, threshold: 0
      }))
      this.hammer.on('pan', this.onPan(this))
    }
  }

  onPan(e) {
    if (!this.isPanning) {
      console.log('coucou');
      this.isPanning = true
      this.topCard.style.transition = null

    //   let style = window.getComputedStyle(this.topCard)
    //   let mx = style.transform.match(/^matrix\((.+)\)$/)
    //   this.startPosX = mx ? parseFloat(mx[1].split(', ')[4]) : 0
    //   this.startPosY = mx ? parseFloat(mx[1].split(', ')[5]) : 0

    //   let bounds = this.topCard.getBoundingClientRect()
    //   this.isDraggingFrom = (e.center.y - bounds.top) > this.topCard.clientHeight / 2 ? -1 : 1
    }

    // let posX = e.deltaX + this.startPosX
    // let posY = e.deltaY + this.startPosY
    // let propX = e.deltaX / this.element.clientWidth
    // let propY = e.deltaY / this.element.clientHeight
    // let dirX = e.deltaX < 0 ? -1 : 1
    // let deg = this.isDraggingFrom * dirX * Math.abs(propX) * 45

    // this.topCard.style.transform = `translateX(${posX}px) translateY(${posY}px) rotate(${deg}deg)`

    // if (e.isFinal) {
    //   this.isPanning = false
    //   this.topCard.style.transition = 'transform 200ms ease-out'

    //   if (propX > 0.25 && e.direction == Hammer.DIRECTION_RIGHT) {
    //     posX = this.element.clientWidth
    //     this.topCard.style.transform = `translateX(${posX}px) translateY(${posY}px) rotate(${deg}deg)`
    //   } else if (propX < -0.25 && e.direction == Hammer.DIRECTION_LEFT) {
    //     posX = - (this.element.clientWidth + this.topCard.clientWidth)
    //     this.topCard.style.transform = `translateX(${posX}px) translateY(${posY}px) rotate(${deg}deg)`
    //   } else if (propY < -0.25 && e.direction == Hammer.DIRECTION_UP) {
    //     posY = - (this.element.clientHeight + this.topCard.clientHeight)
    //     this.topCard.style.transform = `translateX(${posX}px) translateY(${posY}px) rotate(${deg}deg)`
    //   } else {
    //     this.topCard.style.transform = 'translateX(-50%) translateY(-50%) rotate(0deg)'
    //   }
    // }
  }
}
