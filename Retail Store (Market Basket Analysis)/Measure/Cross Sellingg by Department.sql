
WITH t1 AS (
      SELECT
        *
      FROM
        (
          SELECT
            *
          FROM
            icebase.retail_store.order_products
          order by order_id
        )
        LEFT JOIN icebase.retail_store.products USING(product_id)
        LEFT JOIN icebase.retail_store.aisles USING(aisle_id)
         LEFT JOIN icebase.retail_store.departments USING(department_id)
      WHERE
        department_id != 21

)
select fp as e1,sp as e2,tp as e3,to as value
from(
select a.department as fp,b.department as sp,c.department as tp,count(*) as to
from t1 as a ,t1 as b,t1 as c
where a.order_id=b.order_id
and b.order_id=c.order_id
and a.department != b.department and b.department != c.department
and a.department < b.department and b.department < c.department and a.department < c.department
group by 1,2,3

)
where to>=1000
order by 4 desc
limit 50