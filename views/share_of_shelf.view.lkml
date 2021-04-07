view: share_of_shelf {
  sql_table_name: public.sku_manager_skudatapoint ;;
  drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}."id" ;;
    }

    dimension: image_id {
      type: number
      sql: ${TABLE}."image_id" ;;
    }

    dimension: key {
      type: string
      sql: ${TABLE}."key" ;;
    }

    dimension: sku_id {
      type: number
      sql: ${TABLE}."sku_id" ;;
    }

    dimension: value {
      type: string
      sql: ${TABLE}."value" ;;
    }

    dimension: percentage {
      type: number
      sql: REGEXP_REPLACE(${value},'%','','g') ;;
    }

    measure:  percentage_avg{
      type: average
      sql: REGEXP_REPLACE(${value},'%','','g')::integer;;
    }

    measure: count {
      type: count
      drill_fields: [id]
    }

    measure: percentage_avg_100 {
      type: number
      value_format_name: percent_1
      sql: ${percentage_avg}/100 ;;
    }

    measure: percentage_comp_100 {
      type: number
      value_format_name: percent_1
      sql: 1-${percentage_avg_100} ;;
    }
  }
