view: submission_submissionimage {
  sql_table_name: public.submission_submissionimage ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension: exif_data {
    type: string
    sql: ${TABLE}."exif_data" ;;
  }

  dimension: latitude {
    type: string
    sql: ${TABLE}."latitude" ;;
  }

  dimension: longitude {
    type: string
    sql: ${TABLE}."longitude" ;;
  }

  dimension: meta_data_id {
    type: number
    sql: ${TABLE}."meta_data_id" ;;
  }

  dimension: process_logs {
    type: string
    sql: ${TABLE}."process_logs" ;;
  }

  dimension: question_text {
    type: string
    sql: ${TABLE}."question_text" ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}."score" ;;
  }

  dimension: storage {
    type: string
    sql: ${TABLE}."storage" ;;
  }

  dimension: timestamp {
    type: string
    sql: ${TABLE}."timestamp" ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}."url" ;;
  }

  dimension: url_link {
    type: string
    sql: CONCAT('http://jobs.zubale.com//aws/', ${url}) ;;
  }

  dimension: enlace {
    type: string
    sql: ${url} ;;
    label: "Enlace Zubale"
    # html:
    #     {% assign links = {{value}} | split:'|RECORD|' %}
    #       <details>
    #         <summary>Galeria</summary>
    #           <ul>
    #               {% for link in links %}
    #               <li>
    #                 <p>
    #                   <a href='http://jobs.zubale.com//aws/{{link}}' target="_blank"><img height="100" src="http://jobs.zubale.com//aws/{{link}}"></img></a>
    #                 </p>
    #               </li>
    #             {% endfor %}
    #           </ul>
    #       </details>          ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
