project_name: "promotoria_standard_mvp"

application: promotoria_standard_mvp {
  label: "promotoria standard mvp"
  file: "bundle.js"
  entitlements: {
    local_storage: no
    navigation: no
    new_window: no
    use_form_submit: no
    use_embeds: no
    core_api_methods: ["all_looks", "run_look"]
    external_api_urls: []
    oauth2_urls: []
  }
}
