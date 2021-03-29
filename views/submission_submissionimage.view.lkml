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

  measure: count {
    type: count
    drill_fields: [id]
  }
}
