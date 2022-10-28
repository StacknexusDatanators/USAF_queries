select * from
MQL (
  GET 'transaction.campaign_roi'
  FROM
    campaign IN public
  GROUP BY
    'transaction.campaign_id'
)

where "transaction.campaign_id" = 'camp-1'