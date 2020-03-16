require 'zip'
require_relative '../lib/presentation_merger'

class ResourcePackager
  attr_accessor :download

  def initialize(download)
    @download     = download
    @lesson_parts = download.lesson_parts
  end

  def lesson_bundle
    build_lesson_bundle.tap(&:rewind)
  end

private

  def activities
    @lesson_parts.values
  end

  def slide_deck_tempfiles
    activities.map { |activity| activity.slide_deck.attachment.open { |f| f } }
  end

  def combined_slide_deck
    PresentationMerger.write_buffer do |pres|
      slide_deck_tempfiles.each do |file|
        pres << file
      end
    end
  end

  def pupil_resource_blobs
    activities.map(&:pupil_resources).flat_map(&:blobs)
  end

  def teacher_resource_blobs
    activities.map(&:teacher_resources).flat_map(&:blobs)
  end

  def build_lesson_bundle
    Zip::OutputStream.write_buffer do |zip|
      teacher_resource_blobs.each { |blob| add_to_zip(zip, blob, resource_type: 'teacher') }
      pupil_resource_blobs.each   { |blob| add_to_zip(zip, blob, resource_type: 'pupil') }
      add_presentation_to_zip(zip)
    end
  end

  def add_to_zip(zip, blob, resource_type:)
    zip.put_next_entry(File.join(resource_type, blob.filename.to_s))
    zip.write(blob.download)
  end

  def add_presentation_to_zip(zip)
    zip.put_next_entry('teacher/presentation.odp')
    zip.print(combined_slide_deck)
  end
end
