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

  join: share_of_shelf_view {
    from: share_of_shelf
    type: left_outer
    relationship: one_to_many
    sql_on: ${share_of_shelf.id} =  ${submission.id};;
  }

  join: images {
    from: submission_submissionimage
    type: left_outer
    relationship: one_to_many
    sql_on: ${images.meta_data_id} = ${submission.id} ;;
  }

  join: foto_disponibilidad {
    from: submission_submissionimage
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${foto_disponibilidad.meta_data_id} = ${submission.id}
          AND (${foto_disponibilidad.question_text} = 'question text TBD');;
  }

  join: gallery_images {
    from: images_derived
    type: left_outer
    relationship: one_to_many
    sql_on: ${gallery_images.stores_test_id} =  ${submission.id};;
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

  join: share_of_shelf {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${share_of_shelf.sku_id} =  ${responses.id} AND ${share_of_shelf.key} = 'porcentaje';;
  }

  join: share_of_shelf_comp {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${share_of_shelf_comp.sku_id} =  ${responses.id} AND ${share_of_shelf_comp.key} = 'competencia';;
  }

  join: share_bodega_foto {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${share_bodega_foto.sku_id} =  ${responses.id} AND ${share_bodega_foto.key} = 'bodega_foto';;
  }

  join: share_exhibiciones {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${share_exhibiciones.sku_id} =  ${responses.id} AND ${share_exhibiciones.key} = 'exhibiciones';;
  }

  join: share_agotado_foto {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${share_agotado_foto.sku_id} =  ${responses.id} AND ${share_agotado_foto.key} = 'agotado_foto';;
  }

  join: fecha_foto {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${fecha_foto.sku_id} =  ${responses.id} AND ${fecha_foto.key} = 'fecha_foto';;
  }

  join: foto_foto {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${foto_foto.sku_id} =  ${responses.id} AND ${foto_foto.key} = 'foto_foto';;
  }

  join: captura_binary {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${captura_binary.sku_id} =  ${responses.id} AND ${captura_binary.key} = 'captura';;
  }

  join: sku_foto {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_many
    sql_on: ${sku_foto.sku_id} =  ${responses.id} AND ${sku_foto.key} = 'sku_foto';;
  }


}

explore: images_derived {}


explore: share_of_shelf {
  from: submission_submissionmetadata
  sql_always_where: ${share_of_shelf.brand_id} = 287 AND ${approved} ='Yes';;

  join: responses {
    from: sku_manager_skudata
    type: left_outer
    relationship: one_to_many
    sql_on: ${responses.meta_data_id}= ${share_of_shelf.id} ;;
  }

  join: share_name {
    from: sku_manager_skudata
    relationship: one_to_many
    type: left_outer
    sql_on: ${share_of_shelf.id} = ${share_name.meta_data_id} ;;
  }

  join: share_values {
    from: share_of_shelf
    relationship: one_to_one
    type: left_outer
    sql_on: ${share_name.meta_data_id} = ${share_values.id} AND ${share_values.key} = 'porcentaje';;
  }

  join: frio_data {
    from: sku_manager_skudata
    relationship: one_to_many
    type: left_outer
    sql_on: ${frio_data.meta_data_id} = ${share_of_shelf.id} AND ${frio_data.name_string} = 'ANAQUEL FRÍO';;
  }

  join: frio {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${frio.sku_id} = ${frio_data.id} AND ${frio.key} = 'porcentaje' ;;
  }

  join: frio_bool {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${frio_bool.sku_id} = ${frio_data.id} AND ${frio_bool.key} = 'exhibiciones' ;;
  }

  join: islas_data {
    from: sku_manager_skudata
    relationship: one_to_many
    type: left_outer
    sql_on: ${islas_data.meta_data_id} = ${share_of_shelf.id} AND ${islas_data.name_string} = 'ISLAS';;
  }

  join: islas {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${islas.sku_id} = ${islas_data.id} AND ${islas.key} = 'porcentaje' ;;
  }

  join: islas_bool {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${islas_bool.sku_id} = ${islas_data.id} AND ${islas_bool.key} = 'exhibiciones' ;;
  }

  join: seco_data {
    from: sku_manager_skudata
    relationship: one_to_many
    type: left_outer
    sql_on: ${seco_data.meta_data_id} = ${share_of_shelf.id} AND ${seco_data.name_string} = 'ANAQUEL SECO';;
  }

  join: seco {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${seco.sku_id} = ${seco_data.id} AND ${seco.key} = 'porcentaje';;
  }

  join: seco_bool {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${seco_bool.sku_id} = ${seco_data.id} AND ${seco_bool.key} = 'exhibiciones';;
  }

  join: refrigerator_data {
    from: sku_manager_skudata
    relationship: one_to_many
    type: left_outer
    sql_on: ${refrigerator_data.meta_data_id} = ${share_of_shelf.id} AND ${refrigerator_data.name_string} = 'REFRIGERADORES';;
  }

  join: refrigerator {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${refrigerator.sku_id} = ${refrigerator_data.id} AND ${refrigerator.key} = 'porcentaje' ;;
  }

  join: refrigerator_bool {
    from: sku_manager_skudatapoint
    relationship: one_to_one
    type: left_outer
    sql_on: ${refrigerator_bool.sku_id} = ${refrigerator_data.id} AND ${refrigerator_bool.key} = 'exhibiciones' ;;
  }

  join: store {
    from:  location_store
    relationship:  many_to_one
    type:  left_outer
    sql_on: ${share_of_shelf.store_id} = ${store.id} ;;
  }

  join: retailer {
    from:  location_retailer
    relationship: many_to_one
    type:  left_outer
    sql_on: ${store.retailer_id} = ${retailer.id};;
  }

  join: company {
    from: location_company
    relationship: many_to_one
    type: left_outer
    sql_on: ${retailer.company_id} = ${company.id} ;;
  }

  join: images_url {
    from: submission_submissionimage
    type: left_outer
    relationship: one_to_one
    sql_on: ${share_of_shelf.id} = ${images_url.meta_data_id};;
  }
}


  # join: promocion {
  #   from: sku_manager_skudatapoint
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${promocion.sku_id} =  ${responses.id} AND ${promocion.key} = 'promoción';;
  # }
