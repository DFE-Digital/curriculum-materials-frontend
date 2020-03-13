class SlideDeckResource < Resource
  ALLOWED_CONTENT_TYPES = %w(application/vnd.oasis.opendocument.presentation).freeze

  ALLOWED_PREVIEW_CONTENT_TYPES = %w(image/png).freeze

  MAX_UPLOAD_SIZE = 50.megabytes

  validates :type, inclusion: %w(SlideDeckResource).freeze

  # FIXME validate presence of file, there's no point having a slide deck
  # or any other resource type if there's no file!
  validates :file,
            content_type: ALLOWED_CONTENT_TYPES,
            size: { less_than: MAX_UPLOAD_SIZE }

  validates :preview,
            content_type: ALLOWED_PREVIEW_CONTENT_TYPES,
            size: { less_than: MAX_UPLOAD_SIZE }
end
