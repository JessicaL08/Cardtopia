module ApplicationHelper
  def pokemon_image_tag(pokemon)
    if pokemon.image != "/high.webp"
      image_tag(pokemon.image, class: "mandatory-card pokemon-image-info")
    else
      image_tag("Pika-no-image", class: "mandatory-card pokemon-image-info no-image")
    end
  end
end
