
select 
--event_info
	sme.id as event_id, 
	smr.brand_id,
	brn.code,
	sme.seminar_id,
	smr.name,
	sme.seminar_event_type_id,
	smr_et."name",
	sme.seminar_id,
	sme.started_at,
	sme.participation_capacity,
	sme.participants_count,
	sme.cost,
	smr.duration,
	smr.roles_can_see,
	smr.description,
	smr.kpi_type,
	smr.seminar_kpis_type_id,
	smr_kt."name" as kpi_type,
	smr.seminar_specialization_id,
	smr_sp."name",
	sme.description,
--place_training_center
	sme.studio_id,
	sme.salon_id,
	sme.region_id,
	trc."name",
	trc.address,
	trc.center_type,
	trc.description,
	trc.phone,
--place_salons
	sln."name",
	sln.address,
	sln.city,
	sln.email,
	sln.phone,
	sln.url,
	sln.yclients_id,
--educater
	sme.educator_id,code
	edt.last_name || ' ' || edt.first_name as educater_name
from seminar_events as sme
	left join seminars as smr on sme.seminar_id = smr.id
	left join users as edt on sme.educator_id = edt.id
	left join training_centers as trc on sme.studio_id = trc.id
	left join brands as brn on smr.brand_id = brn.id
	left join seminar_event_types as smr_et on sme.seminar_event_type_id = smr_et.id
	left join seminar_kpis_types as smr_kt on smr.seminar_kpis_type_id = smr_kt.id
	left join seminar_specializations as smr_sp on smr.seminar_specialization_id = smr_sp.id
	left join salons as sln on sme.salon_id = sln.id
where sme.id = 329958