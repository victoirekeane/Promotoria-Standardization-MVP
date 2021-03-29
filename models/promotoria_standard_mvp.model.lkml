connection: "zubale_-_zombie"

# include all the views
include: "/views/**/*.view"

datagroup: promotoria_standard_mvp_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: promotoria_standard_mvp_default_datagroup

explore: products {
  from:  sku_manager_skudata
  sql_always_where: ${id} in (select sku.id from sku_manager_skudata sku, submission_submissionmetadata ss where ss.brand_id = 287 and sku.meta_data_id = ss.id);;
}


explore:  stores_test {
  from: location_store
  sql_always_where: ${stores_test.id} in (select store_id from submission_submissionmetadata ss where ss.brand_id = 287);;

  join: retail {
    from: location_retailer
    type: left_outer
    relationship: many_to_one
    sql_on: ${stores_test.retailer_id} = ${retail.id} ;;
  }

  join: submission {
    from: submission_submissionmetadata
    type: left_outer
    relationship: one_to_many
    sql_on: ${submission.store_id} = ${stores_test.id} AND ${submission.brand_id} = 287 AND ${submission.approved} ='Yes';;
  }

  join: responses {
    from: sku_manager_skudata
    type: left_outer
    relationship: one_to_many
    sql_on: ${responses.meta_data_id}= ${submission.id} ;;
  }

  join: disponibilidad {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${disponibilidad.sku_id} =  ${responses.id} AND ${disponibilidad.key} = 'disponibilidad';;
  }

  join: disponible {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${disponible.sku_id} =  ${responses.id} AND ${disponible.value} = 'DISPONIBLE';;
  }

  join: agotado {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${agotado.sku_id} =  ${responses.id} AND ${agotado.value} = 'AGOTADO';;
  }

  join: no_catalogado{
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${no_catalogado.sku_id} =  ${responses.id} AND ${no_catalogado.value} = 'NO CATALOGADO';;
  }

  join: frentes {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${frentes.sku_id} =  ${responses.id} AND ${frentes.key} = 'frentes';;
  }

  join: precio {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${precio.sku_id} =  ${responses.id} AND ${precio.key} = 'precio';;
  }

  join: caducadas {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${caducadas.sku_id} =  ${responses.id} AND ${caducadas.key} = 'caducadas';;
  }

  join: anaqueles {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${anaqueles.sku_id} =  ${responses.id} AND ${anaqueles.key} = 'anaqueles';;
  }

  join: cajas {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${cajas.sku_id} =  ${responses.id} AND ${cajas.key} = 'cajas';;
  }

  join: caja {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${caja.sku_id} =  ${responses.id} AND ${caja.key} = 'caja';;
  }

  join: especifica {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${especifica.sku_id} =  ${responses.id} AND ${especifica.key} = 'especifica';;
  }

  join: captura {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${captura.sku_id} =  ${responses.id} AND ${captura.key} = 'captura';;
  }

  join: sku {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${sku.sku_id} =  ${responses.id} AND ${sku.key} = 'sku';;
  }
}

  # join: promocion {
  #   from: sku_manager_skudatapoint
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${promocion.sku_id} =  ${responses.id} AND ${promocion.key} = 'promoción';;
  # }
