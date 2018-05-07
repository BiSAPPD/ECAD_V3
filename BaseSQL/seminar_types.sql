select *
from seminars as smr
left join brands as brn on smr.brand_id = brn.id
order by smr.brand_id, smr."name"