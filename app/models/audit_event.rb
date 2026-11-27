# A record of an important action (sign-in, content change, user change), kept
# so administrators and IT can see who changed what and when.
class AuditEvent < ApplicationRecord
  belongs_to :user, optional: true

  validates :action, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def self.record!(action, user: nil, target: nil, details: nil, ip: nil)
    create!(
      action: action,
      user: user,
      actor_email: user&.email,
      target_type: target&.class&.name,
      target_id: target&.id,
      target_label: label_for(target),
      details: details.is_a?(String) ? details.presence : details.presence&.to_json,
      ip_address: ip
    )
  rescue ActiveRecord::ActiveRecordError => e
    # An audit problem must never block the action itself.
    Rails.logger.error("Audit event not saved (#{action}): #{e.message}")
    nil
  end

  def self.label_for(target)
    return nil if target.nil?

    %i[title email name].each do |attr|
      return target.public_send(attr).to_s.first(200) if target.respond_to?(attr) && target.public_send(attr).present?
    end
    "##{target.id}"
  end
end
