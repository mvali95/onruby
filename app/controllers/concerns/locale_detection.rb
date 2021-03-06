# frozen_string_literal: true

module LocaleDetection
  protected

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    I18n.locale = allowed_locale?(locale) ? locale : default_locale

    cookies[:locale] = {
      value: locale,
      expires: 1.year.from_now,
      domain: request.domain,
    }
  end

  def allowed_locale?(locale)
    I18n.available_locales.include?(:"#{locale}")
  end

  def default_locale
    Whitelabel.label ? Whitelabel[:default_locale] : I18n.default_locale
  end
end
