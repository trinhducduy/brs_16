class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    ActionController::Base.helpers.asset_path("book-cover-default.png")
  end

  version :thumb do
    process resize_to_fill: [250, 400]
  end

  version :medium do
    process resize_to_fit: [250, 400]
  end
end
