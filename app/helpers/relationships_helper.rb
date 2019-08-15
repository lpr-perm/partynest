# frozen_string_literal: true

module RelationshipsHelper
  def relationship_from_date_or_none(relationship)
    if relationship&.from_date.blank?
      translate :none
    else
      localize relationship.from_date, format: :long
    end
  end

  def relationship_status_or_none(relationship)
    translate_enum :relationship_status, relationship&.status || false
  end
end
