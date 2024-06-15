module ApplicationHelper
  def pokemon_image_tag(pokemon, index = nil)
    if pokemon.image != "/high.webp"
      image_tag(pokemon.image, class: "mandatory-card pokemon-image-info", "data-index": index, id: "#{pokemon.id}")
    else
      image_tag(asset_path("Pika-no-image.png"), class: "mandatory-card pokemon-image-info no-image", "data-index": index, id: "#{pokemon.id}")
    end
  end
end
