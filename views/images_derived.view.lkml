view: images_derived {
  derived_table: {
    sql: SELECT
        stores_test."id"  AS "stores_test.id",
        DATE((responses."created_on" )::timestamptz AT TIME ZONE 'Mexico/General') AS "responses.created_date",
        stores_test."state"  AS "stores_test.state",
        stores_test."city"  AS "stores_test.city",
        retail."name"  AS "retail.name",
        stores_test."name"  AS "stores_test.name",
        retail."company_id"  AS "retail.company_id",
        submission."brand_id"  AS "submission.brand_id",
        anaqueles."value"  AS "anaqueles.value",
        caducadas."value"  AS "caducadas.value",
        cajas."value"  AS "cajas.value",
        captura."value"  AS "captura.value",
        disponibilidad."value"  AS "disponibilidad.value",
        especifica."value"  AS "especifica.value",
        frentes."value"  AS "frentes.value",
        precio."value"  AS "precio.value",
        responses."name_string"  AS "responses.name_string",
        sku."value"  AS "sku.value",
        ARRAY_TO_STRING(ARRAY(SELECT unnest(array_agg(DISTINCT images."url" )) ORDER BY 1),'|RECORD|') AS list_of_url
      FROM public.location_store  AS stores_test
      LEFT JOIN public.location_retailer  AS retail ON (stores_test."retailer_id") = (retail."id")
      LEFT JOIN public.submission_submissionmetadata  AS submission ON (submission."store_id") = (stores_test."id") AND (submission."brand_id") = 287 AND (submission."approved") ='Yes'
      LEFT JOIN public.sku_manager_skudata  AS responses ON (responses."meta_data_id")= (submission."id")
      LEFT JOIN public.submission_submissionimage  AS images ON (images."meta_data_id") = (submission."id")
      LEFT JOIN public.sku_manager_skudatapoint  AS disponibilidad ON (disponibilidad."sku_id") =  (responses."id") AND (disponibilidad."key") = 'disponibilidad'
      LEFT JOIN public.sku_manager_skudatapoint  AS frentes ON (frentes."sku_id") =  (responses."id") AND (frentes."key") = 'frentes'
      LEFT JOIN public.sku_manager_skudatapoint  AS precio ON (precio."sku_id") =  (responses."id") AND (precio."key") = 'precio'
      LEFT JOIN public.sku_manager_skudatapoint  AS caducadas ON (caducadas."sku_id") =  (responses."id") AND (caducadas."key") = 'caducadas'
      LEFT JOIN public.sku_manager_skudatapoint  AS anaqueles ON (anaqueles."sku_id") =  (responses."id") AND (anaqueles."key") = 'anaqueles'
      LEFT JOIN public.sku_manager_skudatapoint  AS cajas ON (cajas."sku_id") =  (responses."id") AND (cajas."key") = 'cajas'
      LEFT JOIN public.sku_manager_skudatapoint  AS especifica ON (especifica."sku_id") =  (responses."id") AND (especifica."key") = 'especifica'
      LEFT JOIN public.sku_manager_skudatapoint  AS captura ON (captura."sku_id") =  (responses."id") AND (captura."key") = 'captura'
      LEFT JOIN public.sku_manager_skudatapoint  AS sku ON (sku."sku_id") =  (responses."id") AND (sku."key") = 'sku'

      WHERE (stores_test."id") in (select store_id from submission_submissionmetadata ss where ss.brand_id = 287)
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
      ORDER BY 2 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: stores_test_id {
    type: string
    sql: ${TABLE}."stores_test.id" ;;
  }

  dimension: responses_created_date {
    type: date
    sql: ${TABLE}."responses.created_date" ;;
  }

  dimension: stores_test_state {
    type: string
    sql: ${TABLE}."stores_test.state" ;;
  }

  dimension: stores_test_city {
    type: string
    sql: ${TABLE}."stores_test.city" ;;
  }

  dimension: retail_name {
    type: string
    sql: ${TABLE}."retail.name" ;;
  }

  dimension: stores_test_name {
    type: string
    sql: ${TABLE}."stores_test.name" ;;
  }

  dimension: retail_company_id {
    type: number
    sql: ${TABLE}."retail.company_id" ;;
  }

  dimension: submission_brand_id {
    type: number
    sql: ${TABLE}."submission.brand_id" ;;
  }

  dimension: anaqueles_value {
    type: string
    sql: ${TABLE}."anaqueles.value" ;;
  }

  dimension: caducadas_value {
    type: string
    sql: ${TABLE}."caducadas.value" ;;
  }

  dimension: cajas_value {
    type: string
    sql: ${TABLE}."cajas.value" ;;
  }

  dimension: captura_value {
    type: string
    sql: ${TABLE}."captura.value" ;;
  }

  dimension: disponibilidad_value {
    type: string
    sql: ${TABLE}."disponibilidad.value" ;;
  }

  dimension: especifica_value {
    type: string
    sql: ${TABLE}."especifica.value" ;;
  }

  dimension: frentes_value {
    type: string
    sql: ${TABLE}."frentes.value" ;;
  }

  dimension: precio_value {
    type: string
    sql: ${TABLE}."precio.value" ;;
  }

  dimension: responses_name_string {
    type: string
    sql: ${TABLE}."responses.name_string" ;;
  }

  dimension: sku_value {
    type: string
    sql: ${TABLE}."sku.value" ;;
  }

  dimension: list_of_url {
    type: string
    sql: ${TABLE}."list_of_url" ;;
  }

  dimension: concat_image_url {
    type: string
    sql: CONCAT('http://jobs.zubale.com//aws/',${TABLE}."list_of_url") ;;
  }

  measure: image_gallery_click {
    type: string
    label: "Image Gallery Click"
    sql:   ${TABLE}."stores_test_name";;
    link: {
      label: "Ver"
      url: "{{ link }}&limit=1"
    }
    html:
          {% assign results_sql = {{value}} %}
          {% for stores_test_name in results_sql %}
          <p>
          <a href={{link}} target="_blank">Ver Fotos
          </a>
          </p>
          {% endfor %};;
          # drill_fields:  [store_store_number,store_name, latest_created_date,pictures_link]
      drill_fields:  [stores_test_name,image_gallery_click]
    }

    dimension: pictures_link_zubale {
      type: string
      sql: ${list_of_url};;
      label: "Image Gallery"
      html:
        {% assign links = {{value}} | split:'|RECORD|' %}
          <details>
            <summary>Galeria</summary>
              <ul>
                  {% for link in links %}
                  <li>
                    <p>
                      <a href='http://jobs.zubale.com//aws/{{link}}' target="_blank"><img height="220" src="http://jobs.zubale.com//aws/{{link}}"></img></a>
                    </p>
                  </li>
                {% endfor %}
              </ul>
          </details>          ;;
    }

  set: detail {
    fields: [
      stores_test_id,
      responses_created_date,
      stores_test_state,
      stores_test_city,
      retail_name,
      stores_test_name,
      retail_company_id,
      submission_brand_id,
      anaqueles_value,
      caducadas_value,
      cajas_value,
      captura_value,
      disponibilidad_value,
      especifica_value,
      frentes_value,
      precio_value,
      responses_name_string,
      sku_value,
      list_of_url
    ]
  }
}
