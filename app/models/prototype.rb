class Prototype < ActiveRecord::Base
  MAX_TAG_LENGTH = 3

  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :prototype_tags, dependent: :destroy
  has_many :tags, through: :prototype_tags
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  accepts_nested_attributes_for :tags, reject_if: :reject_empty_content, allow_destroy: true
  accepts_nested_attributes_for :captured_images, reject_if: :reject_empty_content

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  validates :tags, length: { maximum: MAX_TAG_LENGTH }

  before_save :delete_blank_tag_relation

  def reject_empty_content(attributed)
    attributed['content'].blank?
  end

  # Tagのcontentsが""の場合、Relationを削除
  def delete_blank_tag_relation
    tags.each{ |tag| tag.mark_for_destruction if tag.content.blank? }
    true
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end
end
