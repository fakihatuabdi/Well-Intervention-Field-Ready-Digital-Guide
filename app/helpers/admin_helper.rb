module AdminHelper
  INPUT_CLASS = "w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-800 focus:border-sky-500 focus:ring-2 focus:ring-sky-200 focus:outline-none".freeze
  LABEL_CLASS = "block text-sm font-semibold text-slate-700 mb-1".freeze
  PRIMARY_BUTTON = "inline-block px-4 py-2 rounded-lg bg-sky-600 hover:bg-sky-700 text-white font-semibold text-sm shadow cursor-pointer".freeze
  SECONDARY_BUTTON = "inline-block px-4 py-2 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold text-sm cursor-pointer".freeze
  DANGER_BUTTON = "inline-block px-4 py-2 rounded-lg bg-red-100 hover:bg-red-200 text-red-700 font-semibold text-sm cursor-pointer".freeze

  def admin_input_class
    INPUT_CLASS
  end

  def admin_label_class
    LABEL_CLASS
  end

  def status_badge(text, tone)
    colors = {
      green: "bg-green-100 text-green-700",
      amber: "bg-amber-100 text-amber-800",
      red: "bg-red-100 text-red-700",
      slate: "bg-slate-100 text-slate-600",
      sky: "bg-sky-100 text-sky-700"
    }
    content_tag(:span, text, class: "px-2 py-0.5 rounded-full text-xs font-semibold #{colors.fetch(tone, colors[:slate])}")
  end

  def user_status_badge(user)
    return status_badge("Locked", :red) if user.access_locked?

    tone = { "active" => :green, "pending" => :amber, "disabled" => :slate }.fetch(user.status, :slate)
    status_badge(user.status_label, tone)
  end
end
