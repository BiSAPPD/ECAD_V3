select
sme.id as event_id,
brn.code as brand_code,
to_char(sme.started_at::timestamp at time zone 'UTC','dd.mm.YYYY') as FullDate,
smr."name",
sln.id as salon_id,
sln.name,
sln.address as salon_address,
sln.city,
sln.geo_lat,
sln.geo_lon,
sln.geo_location,
sln.phone,
sln.email,
sln.url,
sln.yclients_id
--sme.description
from seminar_events as sme
left join seminars as smr on sme.seminar_id =smr.id
left join seminar_kpis_types as smrkt on smr.seminar_kpis_type_id = smrkt.id
left join brands as brn on smr.brand_id = brn.id
left join salons as sln on sme.salon_id =sln.id
left join users as edu on sme.educator_id = edu.id
where to_char(sme.started_at,'YYYY') in ('2018') and brn."name" is not null and smrkt."name" = 'Brand Day'
order by brn.code, sme.started_at