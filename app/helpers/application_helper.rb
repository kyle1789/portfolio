module ApplicationHelper
  def localized_record(record, field)
    key = record.try(:title) || record.try(:name)
    slug = key.to_s.parameterize(separator: "_")
    I18n.t("portfolio.records.#{slug}.#{field}", default: record.public_send(field))
  end

  def localized_summary(record)
    localized_record(record, :description).to_s.split(/\n\s*\n/, 2).first
  end
end
