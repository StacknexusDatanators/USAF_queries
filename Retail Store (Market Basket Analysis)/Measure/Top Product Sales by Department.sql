select countbydept.*
  from (

  select department_id, count(1) as counter
    from icebase.retail_store.products
   group by department_id
   order by counter asc
  ) as maxcount
inner join (

  select
    d.department_id,
    d.department,
    count(1) as products
    from icebase.retail_store.departments d
      inner join icebase.retail_store.products p
         on p.department_id = d.department_id
   group by d.department_id, d.department
   order by products desc
  ) countbydept
  on countbydept.products = maxcount.counter
  -- combine the two queries's results by matching the product count  on countbydept.products = maxcount.counter