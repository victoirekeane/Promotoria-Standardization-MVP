project_name: "promotoria_standard_mvp"

application: promotoria_standard_mvp {
  label: "promotoria standard mvp"
  url: "http://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    use_form_submit: yes
    use_embeds: yes
    core_api_methods: ["all_connections","search_folders", "run_inline_query", "me", "all_looks", "run_look"]
    external_api_urls: ["http://localhost:3000"]
    oauth2_urls: []
    scoped_user_attributes: []
    global_user_attributes: []
  }
}
