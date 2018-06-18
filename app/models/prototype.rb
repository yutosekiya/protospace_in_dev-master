class Prototype < ActiveRecord::Base
  MAX_TAG_LENGTH = 3

  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :prototype_tags, dependent: :destroy
  has_many :tags, through: :prototype_tags

  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :captured_images, reject_if: :reject_empty_content

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  validates :tags, length: { maximum: MAX_TAG_LENGTH }

  before_save :delete_blank_tag, :check_tag_existence

  def reject_empty_content(attributed)
    attributed['content'].blank?
  end

  # Tagのcontentsが空の場合は削除
  def delete_blank_tag
    tags.each { |tag| tags.delete(tag) if tag.content.blank? }
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end
end
