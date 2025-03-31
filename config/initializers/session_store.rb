Rails.application.config.session_store :cookie_store,
  key: "_dpi_grades_session",
  same_site: :none,
  secure: true
