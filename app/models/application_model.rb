class ApplicationModel
  include ActiveModel::Model
  include Decoratable

  def assign_attributes(attributes)
    attributes.each { |(field, value)| send("#{field}=", value) }
  end
end
