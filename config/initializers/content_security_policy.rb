# Content Security Policy: the browser may only load scripts, styles, images
# and fonts from this server. Nothing is loaded from the internet (no CDN, no
# Google Fonts, no analytics), so the app also works without internet access.
# Inline <script> blocks must carry the per-request nonce.
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.base_uri    :self
    policy.font_src    :self, :data
    policy.img_src     :self, :data
    policy.object_src  :none
    policy.frame_ancestors :self
    policy.form_action :self
    policy.script_src  :self
    # Tailwind utility classes are static files; inline style attributes are
    # still used by a few views.
    policy.style_src   :self, :unsafe_inline
    if Rails.env.development?
      policy.connect_src :self, "ws://localhost:*", "ws://127.0.0.1:*"
    else
      policy.connect_src :self
    end
  end

  # The nonce must stay the same across Turbo page visits (Turbo copies the
  # nonce of the first page onto scripts of later pages), so one random nonce
  # is kept per session (sessions are encrypted cookies).
  config.content_security_policy_nonce_generator = ->(request) { request.session[:csp_nonce] ||= SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w[script-src]
end
