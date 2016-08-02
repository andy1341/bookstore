class BookDecorator < Drape::Decorator
  delegate_all
  DESC_LENGTH = 300
  def cutted_description
    return object.short_description if object.short_description.length < DESC_LENGTH
      desc = object.short_description.first(DESC_LENGTH).split
      desc.delete_at(-1)
      desc.join(' ') << '...'
  end
end
