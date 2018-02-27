select 
	smr.name as seminar_name, 
	smrkt.name as seminar_type_name, 
	sme.id as seminar_id,  
	to_char(sme.started_at::timestamp at time zone 'UTC','dd.mm.YYYY') as seminar_started_at, 
	trc.name as studio_name,
	trc.address,
	trc.capacity,
	sme.educator_id,
	edu.last_name || ' ' || edu.first_name as educater,
	sme.participation_capacity, 
	sme.participants_count, 
	sme.cost, 
	sme.performed_at, 
	sme.is_closed, 
	prt.user_id,
	prtnm.last_name || ' ' || prtnm.first_name as users,
	prtnm.email,
	prtnm.confirmed_user_agreement,
	prtnm.mobile_number,
	to_char(prtnm.last_request_at::timestamp at time zone 'UTC','dd.mm.YYYY') as last_request_at,
	prtnm.login_count,
	prt.recorded_user_id,
	rec_usr.last_name || ' ' || rec_usr.first_name as rec_users
	from seminars as smr
		left join seminar_kpis_types as smrkt on smr.seminar_kpis_type_id = smrkt.id
		left join seminar_specializations as smrsp on smr.seminar_specialization_id = smrsp.id
		left join seminar_events as sme on smr.id = sme.seminar_id
		---
		left join training_centers as trc on sme.studio_id = trc.id
		left join seminar_event_types as smret on sme.seminar_event_type_id = smret.id
		left join participations as prt on sme.id = prt.seminar_event_id
		---
		left join users as edu on sme.educator_id = edu.id
		left join users as prtnm on prt.user_id = prtnm.id
		left join users as rec_usr on prt.recorded_user_id = rec_usr.id
	where smrkt.name = 'LBS'
	order by sme.started_at desc , smr.id