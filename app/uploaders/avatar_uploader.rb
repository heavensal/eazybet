class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Définir le dossier de stockage sur Cloudinary
  def store_dir
    "eazybetcoinapp/avatars"
  end

  # Formats autorisés
  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  # Optionnel : Créer différentes versions de l'image
  version :thumb do
    process resize_to_fit: [ 50, 50 ]
  end

  version :medium do
    process resize_to_fit: [ 200, 200 ]
  end

  # Optionnel : Définir des paramètres de transformation Cloudinary
  process convert: "png"
  process tags: [ "avatar" ]
end
