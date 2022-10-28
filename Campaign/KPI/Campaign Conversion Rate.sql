select * from
MQL (
  GET 'transaction.conversion_rate'
  FROM
    campaign IN public
  GROUP BY
    'transaction.campaign_id'
)
where "transaction.campaign_id" = 'camp-1'