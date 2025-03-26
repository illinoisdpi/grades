Rails.application.config.session_store :cookie_store,
  key: "_lti_provider_example_session",
  same_site: :none,
  secure: true
